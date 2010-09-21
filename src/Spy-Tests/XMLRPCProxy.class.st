"
Proxy class to issue XML-RPC requests.

	Example (invoking a method that takes a single integer argument):

	u _ Url absoluteFromText: 'http://bleu.west.spy.net/servlet/net.spy.rpc.XMLRPC'.
	proxy _ XMLRPCProxy withUrl: u.
	proxy invokeMethod: 'echo.echoInt' withArgs: #(1).
"
Class {
	#name : #XMLRPCProxy,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #'Spy-XML-RPC'
}

{ #category : #'instance creation' }
XMLRPCProxy class >> withUrl: u [
	"Get a new instance of XMLRPCProxy to connect to a given URL."
	^ XMLRPCProxy new url: u
]

{ #category : #private }
XMLRPCProxy >> buildXmlRpc: method withArgs: args [ 
	"Build the XMLRPC data required to invoke the given method with the 
	given collection of arguments."
	| params e rv |
	e _ XMLRPCEncoder new.
	params _ Text new.
	args
		do: [:p | params append: '<param>'
					, (e encode: p) , '</param>'].
	rv _ '<?xml version="1.0"?><methodCall><methodName>' , method , '</methodName><params>' , params , '</params></methodCall>'.

rv := '<?xml version="1.0"?><methodCall>
	<methodName>flickr.test.echo</methodName>
	<params>
		<param>
			<value>
				<struct>
					<member>
						<name>name</name>
						<value><string>garduino</string></value>
					</member>
					<member>
						<name>api_key</name>
						<value><string>b7d7df90f7c8ba3fd6f7012d5d5bc64c</string></value>
					</member>
				</struct>
			</value>
		</param>
	</params>
</methodCall>'.
	
	self halt.

	^ rv
]

{ #category : #invoking }
XMLRPCProxy >> invokeMethod: method [ 
	"Invoke a method on the XML-RPC server with no arguments."
	^ self invokeMethod: method withArgs: #()
]

{ #category : #invoking }
XMLRPCProxy >> invokeMethod: method withArgs: args [ 
	"Invoke a method on the XML-RPC server.

	args is a list of parameters to be passed.  For example, if the remote method is called ``test.Method'' and takes two ints, you'd invoke is like this:

	anXMLRPCProxy invokeMethod: 'test.method' withArgs: #(19 77)
"
	| req res rv |
	req _ self buildXmlRpc: method withArgs: args.
	res _ self sendXmlRpc: req.
	rv _ self processResponse: res.
	^ rv
]

{ #category : #private }
XMLRPCProxy >> processFault: xmlFault [ 
	"Process an XML-RPC fault into an XMLRPCFaultException"
	| d decoder |
	decoder _ XMLRPCDecoder new.
	d _ decoder decode: xmlFault.
	XMLRPCFaultException
		signal: (d at: 'faultCode')
		withMessage: (d at: 'faultString').
]

{ #category : #private }
XMLRPCProxy >> processResponse: xmlStream [ 
	"Process the results."
	| xmldoc mr fr pr |
	
	self halt.
	
	xmldoc _ XMLDOMParser parseDocumentFrom: xmlStream.
	mr _ xmldoc elementAt: 'methodResponse'.
	mr
		ifNil: [XMLRPCException signal: 'methodResponse not found in XML Stream.'].
	"See if it's a fault response."
	fr _ mr elementAt: 'fault'.
	fr
		ifNotNil: [self processFault: fr].
	"If we made it this far, it's a valid response, look for the results."
	pr _ mr elementAt: 'params'.
	pr
		ifNil: [XMLRPCException signal: 'Params not found in XML-RPC response.'].
	"Decode, and return the response."
	^ XMLRPCDecoder new decode: pr
]

{ #category : #private }
XMLRPCProxy >> sendXmlRpc: data [ 
	"Send the XML-RPC data and get the response. Return the raw XML."
	| s req res xml |
	s _ HTTPSocket initHTTPSocket: url ifError: [:msg | XMLRPCException signal: 'Error connecting ' , url asString, '(', msg, ')'].
	req _ 'POST ' , url fullPath , ' HTTP/1.0' , String crlf , 'Host: ' , url authority , String crlf , 'Content-type: text/xml' , String crlf , 'Content-length:  ' , data size asString , String crlf , 'User-Agent:  Spy Internetworking XML-RPC client for Smalltalk' , String crlf , String crlf , data.
	"Send the command"
	s sendCommand: req.
	"Make sure the result was valid."
	s responseCode = 200
		ifFalse: ['XXX Raise exception.'].
	"Get the data up to the first double-newline (indicating end of headers)"
	res _ s getResponseUpTo: String crlf , String crlf.
	xml _ s getRestOfBuffer: (res at: 3) contents.
	^ xml
]

{ #category : #accessing }
XMLRPCProxy >> url [
	"Get the URL against which requests will be invoked."
	^ url
]

{ #category : #initializing }
XMLRPCProxy >> url: aUrl [
	"Set the URL that will be servicing the requests."
	url _ aUrl
]
