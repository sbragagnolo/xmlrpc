Class {
	#name : #XMLRPCTest,
	#superclass : #SpyTest,
	#instVars : [
		'proxy'
	],
	#category : #'Spy-XML-RPC-Test'
}

{ #category : #Testing }
XMLRPCTest >> performCall: method arg: a [ 
	"Perform method invocation and make sure the result is the same as the  
	passed-in value."
	| r p |
	p _ OrderedCollection new.
	p add: a.
	r _ proxy invokeMethod: method withArgs: p.
	"Transcript show: 'Invoked ' , method , ' with ' , a asString , ' which returned ' , r asString;
		 cr."
	self
		assertEquals: a
		to: r
		msg: 'Failed on method ' , method.

]

{ #category : #Testing }
XMLRPCTest >> setUp [
	"Set up the test suite:"
	| url |
	url _ Url absoluteFromText: 'http://bleu.west.spy.net/servlet/net.spy.rpc.XMLRPC'.
	proxy _ XMLRPCProxy new url: url.
	"Transcript show: 'Set up XMLRPCTest';
		 cr."

	^ self
]

{ #category : #Testing }
XMLRPCTest >> suite [
	^ (TestSuite named: 'XMLRPCTests')
		addTest: (XMLRPCTest selector: #testInt);
		
		addTest: (XMLRPCTest selector: #testDouble);
		
		addTest: (XMLRPCTest selector: #testString);
		
		addTest: (XMLRPCTest selector: #testBoolean);
		
		addTest: (XMLRPCTest selector: #testArray);
		
		addTest: (XMLRPCTest selector: #testStruct);
		
		addTest: (XMLRPCTest selector: #testDate);

		addTest: (XMLRPCTest selector: #testBinary)
]

{ #category : #Testing }
XMLRPCTest >> testArray [
	"Test arrays."
	self performCall: 'echo.echoArray' arg: #('A' 1 3 2.525)
]

{ #category : #Testing }
XMLRPCTest >> testBinary [
	"Test Binary data."
	| r p msg |
	msg _ 'Test for base64.'.
	p _ OrderedCollection new.
	p add: msg readStream.
	r _ proxy invokeMethod: 'echo.echoByte' withArgs: p.

	self assertEquals: msg to: (r contents asString) msg: 'Binary (base64) method failed.'
]

{ #category : #Testing }
XMLRPCTest >> testBoolean [
	"Test booleans."
	self performCall: 'echo.echoBoolean' arg: true.
	self performCall: 'echo.echoBoolean' arg: false
]

{ #category : #Testing }
XMLRPCTest >> testDateTime [
	"Test DateTime."
	self performCall: 'echo.echoDate' arg: (XMLRPCDateTime now)
]

{ #category : #Testing }
XMLRPCTest >> testDouble [
	"Test doubles."
	self performCall: 'echo.echoDouble' arg: 3.14159265358979
]

{ #category : #Testing }
XMLRPCTest >> testInt [
	"Test ints."
	self performCall: 'echo.echoInt' arg: 19.
]

{ #category : #Testing }
XMLRPCTest >> testString [
	"Test strings."
	self performCall: 'echo.echoString' arg: 'This is a test message.'.
	self performCall: 'echo.echoString' arg: 'Embedded XML <see>.'.
]

{ #category : #Testing }
XMLRPCTest >> testStruct [
	"Test structs."
	| d |
	d _ Dictionary new.
	d at: 'a' put: 'Value for A'.
	d at: 'b' put: 'Value for B'.
	self performCall: 'echo.echoStruct' arg: d
]
