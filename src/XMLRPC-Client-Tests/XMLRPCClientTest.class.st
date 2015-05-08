Class {
	#name : #XMLRPCClientTest,
	#superclass : #XMLRPCClientBaseTest,
	#instVars : [
		'proxy',
		'server'
	],
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #'test support' }
XMLRPCClientTest >> performCall: method arg: a [ 
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
XMLRPCClientTest >> performCall: method struct: a [ 
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
XMLRPCClientTest >> setUp [
	server := XMLRPCServerForTest new startOn: 8081.
	proxy := XMLRPCProxy new url: 'http://localhost:8081/' asZnUrl

]

{ #category : #'instance creation' }
XMLRPCClientTest >> suite [
	^ (TestSuite named: 'XMLRPCTests')
		addTest: (XMLRPCClientTest selector: #testInt);
		
		addTest: (XMLRPCClientTest selector: #testDouble);
		
		addTest: (XMLRPCClientTest selector: #testString);
		
		addTest: (XMLRPCClientTest selector: #testBoolean);
		
		addTest: (XMLRPCClientTest selector: #testArray);
		
		addTest: (XMLRPCClientTest selector: #testStruct);
		
		addTest: (XMLRPCClientTest selector: #testDate);

		addTest: (XMLRPCClientTest selector: #testBinary)
]

{ #category : #running }
XMLRPCClientTest >> tearDown [
	server stop
]

{ #category : #tests }
XMLRPCClientTest >> testArray [
	"Test arrays."

	self performCall: 'echo.echoArray' arg: #('A' 1 3 2.525)
]

{ #category : #tests }
XMLRPCClientTest >> testBinary [
	"Test Binary data."
	| r p msg |
	msg := 'Test for base64.'.
	p := OrderedCollection new.
	p add: msg readStream.
	r := proxy invokeMethod: 'echo.echoBinary' withArgs: p.
	
	self assertEquals: msg to: (r contents asString) msg: 'Binary (base64) method failed.'
]

{ #category : #tests }
XMLRPCClientTest >> testBoolean [
	"Test booleans."
	self performCall: 'echo.echoBoolean' arg: true.
	self performCall: 'echo.echoBoolean' arg: false
]

{ #category : #tests }
XMLRPCClientTest >> testDateTime [
	"Test DateTime."
	self performCall: 'echo.echoDateTime' arg: (XMLRPCDateTime now)
]

{ #category : #tests }
XMLRPCClientTest >> testDouble [
	"Test doubles."
	self performCall: 'echo.echoDouble' arg: 3.14159265358979
]

{ #category : #tests }
XMLRPCClientTest >> testInt [
	"Test ints."
	self performCall: 'echo.echoInt' arg: 19.
]

{ #category : #tests }
XMLRPCClientTest >> testString [
	"Test strings."
	self performCall: 'echo.echoString' arg: 'This is a test message.'.
	self performCall: 'echo.echoString' arg: 'Embedded XML see  .'.  "implicit < > tags need to be handled"
]

{ #category : #tests }
XMLRPCClientTest >> testStruct [
	"Test structs."
	| d |

	d := Dictionary new.
	d at: 'a' put: 'Value for A'.
	d at: 'b' put: 'Value for B'.

	self performCall: 'echo.echoStruct' struct: d
]
