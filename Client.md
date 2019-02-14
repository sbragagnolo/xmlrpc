# XMLRPC-Client-Core - Generated Doc
## Manifest
XMLRPC Client implements a client for interacting with a remote / local XMLRPC server. 
Wikipedia [https://en.wikipedia.org/wiki/XML-RPC]


## XMLRPCDateTime
DateTime object for sending and receiving dates via XML-RPC.
	See the convenience class methods for easily creating instances of this class.

### Properties
date
time

### Methods
#### XMLRPCDateTime>>encodeISO8601
Encode me into an ISO8601 datetime for XML-RPC

#### XMLRPCDateTime>>decodeISO8601: s
Set the date and time in this object by parsing the ISO8601 string.


### Class Methods
#### XMLRPCDateTime class>>now
Get a new XMLRPCDateTime instance representing the current time.

#### XMLRPCDateTime class>>fromISO8601String: s
Get a new XMLRPCDateTime instance from the given ISO8601 string.

#### XMLRPCDateTime class>>fromDate: d time: t
Get a new XMLRPCDateTime instance from the given date and time.



## XMLRPCProxy
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



### Properties
url

### Methods
#### XMLRPCProxy>>invokeMethod: aString withArgs: anArray
Invoke a method on the XML-RPC server.
	       args is a list of parameters to be passed.  For example, if the remote method is called ``test.Method' and takes two ints, youd invoke is like this:
   	       anXMLRPCProxy invokeMethod: "test.method" withArgs: #(19 77)

#### XMLRPCProxy>>invokeMethod: method withStruct: args
Invoke a method on the XML-RPC server.
	A value can also be of type <struct>.
	A <struct> contains <member>s and each <member> contains a <name> and a <value>.
	We call a struct using a Dictionay, because each entry already have 2 elements.

#### XMLRPCProxy>>sendXmlRpc: data
Send the XML-RPC data and get the response. Return the raw XML.

#### XMLRPCProxy>>buildXmlRpc: methodString withArgs: anArray
Build the XMLRPC data required to invoke the given method with the 
	given collection of arguments.

#### XMLRPCProxy>>processResponse: xmlStream
Process the results.

#### XMLRPCProxy>>invokeMethod: aString
Invoke a method on the XML-RPC server with no arguments.

#### XMLRPCProxy>>processFault: xmlFault
Process an XML-RPC fault into an XMLRPCFaultException


### Class Methods
#### XMLRPCProxy class>>withUrl: u
Get a new instance of XMLRPCProxy to connect to a given URL.




