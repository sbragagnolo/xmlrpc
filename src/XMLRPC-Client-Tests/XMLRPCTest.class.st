Class {
	#name : #XMLRPCTest,
	#superclass : #XMLRPCClientTests,
	#instVars : [
		'proxy'
	],
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #'test support' }
XMLRPCTest >> performCall: method arg: a [ 
	"Perform method invocation and make sure the result is the same as the  
	passed-in value."
	| r p |
	p := OrderedCollection new.
	p add: a.
	r := proxy invokeMethod: method withArgs: p.
	"Transcript show: 'Invoked ' , method , ' with ' , a asString , ' which returned ' , r asString;
		 cr."
	self
		assertEquals: a
		to: r
		msg: 'Failed on method ' , method.

]

{ #category : #'test support' }
XMLRPCTest >> performCall: method struct: a [ 
	"Perform method invocation and make sure the result is the same as the  
	passed-in value."
	| r p |

	r := proxy invokeMethod: method withStruct: a.
	"Transcript show: 'Invoked ' , method , ' with ' , a asString , ' which returned ' , r asString;
		 cr."
	self
		assertEquals: a
		to: r
		msg: 'Failed on method ' , method.

]

{ #category : #running }
XMLRPCTest >> setUp [
	"Set up the test suite:"
	| url |
	XMLRPCKomServerEchoTest  new setUp. "get the server running on the other end.. make it through groovy/ python if you wish.. Server stop is set in the tearDown"
	url := ZnUrl fromString: 'http://localhost:8081/'.
	proxy := XMLRPCProxy new url: url.
	"Transcript show: 'Set up XMLRPCTest';
		 cr."

	^ self
]

{ #category : #'instance creation' }
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

{ #category : #running }
XMLRPCTest >> tearDown [
	XMLRPCHttpModule stop
]

{ #category : #tests }
XMLRPCTest >> testArray [
	"Test arrays."

	self performCall: 'echo.echoArray' arg: #('A' 1 3 2.525)
]

{ #category : #tests }
XMLRPCTest >> testBinary [
	"Test Binary data."
	| r p msg |
	msg := 'Test for base64.'.
	p := OrderedCollection new.
	p add: msg readStream.
	r := proxy invokeMethod: 'echo.echoBinary' withArgs: p.
	
	self assertEquals: msg to: (r contents asString) msg: 'Binary (base64) method failed.'
]

{ #category : #tests }
XMLRPCTest >> testBoolean [
	"Test booleans."
	self performCall: 'echo.echoBoolean' arg: true.
	self performCall: 'echo.echoBoolean' arg: false
]

{ #category : #tests }
XMLRPCTest >> testDateTime [
	"Test DateTime."
	self performCall: 'echo.echoDateTime' arg: (XMLRPCDateTime now)
]

{ #category : #tests }
XMLRPCTest >> testDouble [
	"Test doubles."
	self performCall: 'echo.echoDouble' arg: 3.14159265358979
]

{ #category : #tests }
XMLRPCTest >> testInt [
	"Test ints."
	self performCall: 'echo.echoInt' arg: 19.
]

{ #category : #tests }
XMLRPCTest >> testString [
	"Test strings."
	self performCall: 'echo.echoString' arg: 'This is a test message.'.
	self performCall: 'echo.echoString' arg: 'Embedded XML see  .'.  "implicit < > tags need to be handled"
]

{ #category : #tests }
XMLRPCTest >> testStruct [
	"Test structs."
	| d |

	d := Dictionary new.
	d at: 'a' put: 'Value for A'.
	d at: 'b' put: 'Value for B'.

	self performCall: 'echo.echoStruct' struct: d
]
