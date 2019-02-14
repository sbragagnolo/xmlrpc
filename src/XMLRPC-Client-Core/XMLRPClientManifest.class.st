"
XMLRPC Client implements a client for interacting with a remote / local XMLRPC server. 

Wikipedia [https://en.wikipedia.org/wiki/XML-RPC]

"
Class {
	#name : #XMLRPClientManifest,
	#superclass : #PackageManifest,
	#category : #'XMLRPC-Client-Core'
}

{ #category : #'as yet unclassified' }
XMLRPClientManifest class >> exampleCreateProxy [
	| proxy |
	proxy := XMLRPCProxy new url: 'http://localhost:8081/' asZnUrl
]

{ #category : #'as yet unclassified' }
XMLRPClientManifest class >> exampleInvokeOnRemoteMethodWithArguments [
	| proxy |
	proxy := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	proxy invokeMethod: 'validator1.echoStructTest' withArgs: #('Hallo')
]

{ #category : #'as yet unclassified' }
XMLRPClientManifest class >> exampleInvokeOnRemoteMethodWithStruct [
	| proxy data |
	data := Dictionary new.
	data at: 'true' put: true.
	data at: 'Markus' put: 'Fritsche'.
	proxy := XMLRPCProxy new url: 'http://localhost:8081/' asZnUrl.
	proxy invokeMethod: 'validator1.echoStructTest' withStruct: data
]
