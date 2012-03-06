"
Proxy class to issue XML-RPC requests.

	Example (invoking a method that takes a single integer argument):

	u := Url absoluteFromText: 'http://bleu.west.spy.net/servlet/net.spy.rpc.XMLRPC'.
	proxy := XMLRPCProxy withUrl: u.
	proxy invokeMethod: 'echo.echoInt' withArgs: #(1).
	
	Flickr Example:
	
	| url proxy r |

	url := Url absoluteFromText: 'http://api.flickr.com/services/xmlrpc/'.

	proxy := XMLRPCProxy new url: url.

	d := Dictionary new.
	d at: 'name' put: 'flickruser'.
	d at: 'api_key' put: 'flickrkey'.

	r := proxy invokeMethod: 'flickr.test.echo' withStruct: d.




"
Class {
	#name : #XMLRPCProxy,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #'XMLRPC-Client-Core'
}

{ #category : #'instance creation' }
XMLRPCProxy class >> withUrl: u [
	"Get a new instance of XMLRPCProxy to connect to a given URL."
	^ self new url: u
]

{ #category : #private }
XMLRPCProxy >> buildParamsFrom: anArrayOfArguments [

	| params encoder |
	encoder := self encoderClass new.
	params := String new writeStream.
	anArrayOfArguments do: [ :p | 
		params nextPutAll: '<param>', (encoder encode: p), '</param>' ].
	^ params contents.
]

{ #category : #private }
XMLRPCProxy >> buildXmlRpc: methodString withArgs: anArray [ 

	"Build the XMLRPC data required to invoke the given method with the 
	given collection of arguments."

	^ '<?xml version="1.0"?><methodCall><methodName>' , methodString, '</methodName><params>' , (self buildParamsFrom: anArray), '</params></methodCall>'.
]

{ #category : #private }
XMLRPCProxy >> buildXmlRpc: method withStruct: args [ 
	"Build the XMLRPC data required to invoke the given method with the 
	given collection of arguments."
	| params e rv |
	e := XMLRPCEncoder new.
	params := Text new.

	params append: '<param><value>'	, (e encodeStruct: args) , '</value></param>'.
	
	rv := '<?xml version="1.0"?><methodCall><methodName>' , method , '</methodName><params>' , params , '</params></methodCall>'.
	
	^ rv
]

{ #category : #private }
XMLRPCProxy >> encoderClass [

	^ XMLRPCEncoder.
]

{ #category : #invoking }
XMLRPCProxy >> invokeMethod: aString [ 
	"Invoke a method on the XML-RPC server with no arguments."
	
	^ self invokeMethod: aString withArgs: #()
]

{ #category : #invoking }
XMLRPCProxy >> invokeMethod: aString withArgs: anArray [ 
	"Invoke a method on the XML-RPC server.

	args is a list of parameters to be passed.  For example, if the remote method is called ``test.Method'' and takes two ints, you'd invoke is like this:

	anXMLRPCProxy invokeMethod: 'test.method' withArgs: #(19 77)
"
	| request response |
	request := self buildXmlRpc: aString withArgs: anArray.
	response := self sendXmlRpc: request.
	^ self processResponse: response.
]

{ #category : #invoking }
XMLRPCProxy >> invokeMethod: method withStruct: args [
	"Invoke a method on the XML-RPC server.

	A value can also be of type <struct>.

	A <struct> contains <member>s and each <member> contains a <name> and a <value>.

	We call a struct using a Dictionay, because each entry already have 2 elements."

	| req res rv |


	" TODO A dictionary is requested here, check to document and improve method name, modify test"
	
		args class = Dictionary 
		ifFalse: [ XMLRPCFaultException signal: 100 withMessage: 'You must pass a Dictionary to call a struct' ]
		ifTrue: [ 
			req := self buildXmlRpc: method withStruct: args.
			res := self sendXmlRpc: req.
			rv := self processResponse: res.
			^ rv ]	
		
		
		
		

]

{ #category : #private }
XMLRPCProxy >> processFault: xmlFault [ 
	"Process an XML-RPC fault into an XMLRPCFaultException"
	| d decoder |
	decoder := XMLRPCDecoder new.
	d := decoder decode: xmlFault.
	XMLRPCFaultException
		signal: (d at: 'faultCode')
		withMessage: (d at: 'faultString').
]

{ #category : #private }
XMLRPCProxy >> processResponse: xmlStream [ 
	"Process the results."
	| xmldoc mr fr pr |
	xmldoc := XMLDOMParser parseDocumentFrom: xmlStream.
	mr := xmldoc elementAt: 'methodResponse'.
	mr
		ifNil: [XMLRPCException signal: 'methodResponse not found in XML Stream.'].
	"See if it's a fault response."
	fr := mr elementAt: 'fault'.
	fr
		ifNotNil: [self processFault: fr].
	"If we made it this far, it's a valid response, look for the results."
	pr := mr elementAt: 'params'.
	pr
		ifNil: [XMLRPCException signal: 'Params not found in XML-RPC response.'].
	"Decode, and return the response."
	" self halt. "
	^ XMLRPCDecoder new decode: pr
]

{ #category : #private }
XMLRPCProxy >> sendXmlRpc: data [ 
	"Send the XML-RPC data and get the response. Return the raw XML."
	| s req res xml |


xml := ZnClient new
 	      url: url;
  	     entity: (ZnEntity with: data type: ZnMimeType applicationXml);
  	     post.

"
	s := HTTPSocket initHTTPSocket: url ifError: [:msg | XMLRPCException signal: 'Error connecting ' , url asString, '(', msg, ')'].

	req := 'POST ' , url fullPath , ' HTTP/1.0' , String crlf , 'Host: ' , url authority , String crlf , 'Content-type: text/xml' , String crlf , 'Content-length:  ' , data size asString , String crlf , 'User-Agent:  Spy Internetworking XML-RPC client for Smalltalk' , String crlf , String crlf , data.
"
	"Send the command"
	"s sendCommand: req."

	"Make sure the result was valid."
	"s responseCode = 200
		ifFalse: ['XXX Raise exception.']."
	"Get the data up to the first double-newline (indicating end of headers)"
	" res := s getResponseUpTo: String crlf , String crlf.
	xml := s getRestOfBuffer: (res at: 3) contents."
	^ xml
]

{ #category : #private }
XMLRPCProxy >> sendXmlRpcBAK: data [ 
	"Send the XML-RPC data and get the response. Return the raw XML."
	| s req res xml |
	s := HTTPSocket initHTTPSocket: url ifError: [:msg | XMLRPCException signal: 'Error connecting ' , url asString, '(', msg, ')'].
	req := 'POST ' , url fullPath , ' HTTP/1.0' , String crlf , 'Host: ' , url authority , String crlf , 'Content-type: text/xml' , String crlf , 'Content-length:  ' , data size asString , String crlf , 'User-Agent:  Spy Internetworking XML-RPC client for Smalltalk' , String crlf , String crlf , data.
	"Send the command"
	s sendCommand: req.
	"Make sure the result was valid."
	s responseCode = 200
		ifFalse: ['XXX Raise exception.'].
	"Get the data up to the first double-newline (indicating end of headers)"
	res := s getResponseUpTo: String crlf , String crlf.
	xml := s getRestOfBuffer: (res at: 3) contents.
	^ xml
]

{ #category : #accessing }
XMLRPCProxy >> url [
	"Get the URL against which requests will be invoked."
	^ url
]

{ #category : #accessing }
XMLRPCProxy >> url: aUrl [
	"Set the URL that will be servicing the requests."
	url := aUrl
]
