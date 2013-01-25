Class {
	#name : #XMLRPCZNServerTest,
	#superclass : #TestCase,
	#instVars : [
		'newServer'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCZNServerTest >> setUp [
	XMLRPCServer defaultClass: XMLRPCZNServer.
	XMLRPCStandardValidator addTests.
	(Delay forMilliseconds: 5) wait.
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerTest >> tearDown [
	XMLRPCService destroy.
	XMLRPCServer initialize.
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerTest >> testDictionary [
	| d p r |
	d := Dictionary new.
	d at: 'true' put: true.
	d at: 'Markus' put: 'Fritsche'.
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	r := p invokeMethod: 'validator1.echoStructTest' withStruct: d.
	self assert: r = d
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerTest >> testHallo [
	| p |
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	p invokeMethod: 'validator1.echoStructTest' withArgs: #('Hallo')

]
