Class {
	#name : #XMLRPCServerTest,
	#superclass : #TestCase,
	#instVars : [
		'newServer'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> setUp [
	
	XMLRPCStandardValidator addTests.
	(Delay forMilliseconds: 5) wait.
]

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> tearDown [
	XMLRPCService destroy.

]

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> testDictionary [
	| d p r |
	d := Dictionary new.
	d at: 'true' put: true.
	d at: 'Markus' put: 'Fritsche'.
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	r := p invokeMethod: 'validator1.echoStructTest' withStruct: d.
	self assert: r = d
]

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> testHallo [
	| p |
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	p invokeMethod: 'validator1.echoStructTest' withArgs: #('Hallo')

]
