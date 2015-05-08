Class {
	#name : #XMLRPCServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #running }
XMLRPCServerTest >> setUp [
	server := XMLRPCServerForTest new startOn: 8081
]

{ #category : #running }
XMLRPCServerTest >> tearDown [
	server stop
]

{ #category : #tests }
XMLRPCServerTest >> testDictionary [
	| d p r |
	d := Dictionary new.
	d at: 'true' put: true.
	d at: 'Markus' put: 'Fritsche'.
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	r := p invokeMethod: 'validator1.echoStructTest' withStruct: d.
	self assert: r = d
]

{ #category : #tests }
XMLRPCServerTest >> testHallo [
	| p |
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	p invokeMethod: 'validator1.echoStructTest' withArgs: #('Hallo')

]

{ #category : #tests }
XMLRPCServerTest >> testThroughClient [
" bring in tests here independently in next version.. for now just reuse the XMLRPCTests"

 | client |
 client := XMLRPCClientTest suite.
 client run.

]
