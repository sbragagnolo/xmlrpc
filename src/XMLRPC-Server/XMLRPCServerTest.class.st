Class {
	#name : #XMLRPCServerTest,
	#superclass : #TestCase,
	#instVars : [
		'newServer'
	],
	#category : #'XMLRPC-Server-Test'
}

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> setUp [
	newServer := false.
	XMLRPCStandardValidator addTests.
	(HttpService servicesNamed: 'xmlrpc') 
		ifEmpty: [XMLRPCHttpModule start; setDebugMode.
			newServer := true]
]

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> tearDown [
	#('validator1.arrayOfStructsTest' 'validator1.countTheEntities' 'validator1.echoStructTest' 'validator1.easyStructTest' 'validator1.moderateSizeArrayCheck' 'validator1.nestedStructTest' 'validator1.simpleStructReturnTest' 'validator1.manyTypesTest') do: [ :xmlrpcService |
	XMLRPCServerRequest removeService: xmlrpcService asSymbol].
	newServer ifTrue: [ XMLRPCHttpModule stop ]
]

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> testDictionary [
	| d p r |
	d := Dictionary new.
	d at: 'true' put: true.
	d at: 'Markus' put: 'Fritsche'.
	p := XMLRPCProxy new url: 'http://localhost:8081/xmlrpc' asUrl.
	r := p invokeMethod: 'validator1.echoStructTest' withArgs: {d}.
	self assert: (r = d)
	

]

{ #category : #'as yet unclassified' }
XMLRPCServerTest >> testHallo [
	| p |
	p := XMLRPCProxy new url: 'http://localhost:8081/xmlrpc' asUrl.
	p invokeMethod: 'validator1.echoStructTest' withArgs: #('Hallo')

]
