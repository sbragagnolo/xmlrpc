Class {
	#name : #XMLRPCKomServerTest,
	#superclass : #TestCase,
	#instVars : [
		'newServer'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCKomServerTest >> setUp [
	XMLRPCServer defaultClass: XMLRPCKomServer.
	XMLRPCStandardValidator addTests.
	(Delay forMilliseconds: 5) wait.
]

{ #category : #'as yet unclassified' }
XMLRPCKomServerTest >> tearDown [
	XMLRPCService destroy.
	XMLRPCServer initialize.
]

{ #category : #'as yet unclassified' }
XMLRPCKomServerTest >> testDictionary [
	| d p r |
	d := Dictionary new.
	d at: 'true' put: true.
	d at: 'Markus' put: 'Fritsche'.
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	r := p invokeMethod: 'validator1.echoStructTest' withStruct: d.
	self assert: r = d
]

{ #category : #'as yet unclassified' }
XMLRPCKomServerTest >> testHallo [
	| p |
	p := XMLRPCProxy new url: 'http://localhost:8081/' asUrl.
	p invokeMethod: 'validator1.echoStructTest' withArgs: #('Hallo')

]
