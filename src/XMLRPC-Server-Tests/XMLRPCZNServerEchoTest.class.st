Class {
	#name : #XMLRPCZNServerEchoTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCZNServerEchoTest >> setUp [
	| delegate |
	XMLRPCServer defaultClass: XMLRPCZNServer.
	XMLRPCStandardEcho addTests.
	
	server := ZnServer on:  8081.
	delegate := ZnDispatcherDelegate new.
	
	XMLRPCServerRequest receivers keysAndValuesDo: [
		:key :value | 
		delegate map: key to: [ :request :response |  
			response entity: (ZnStringEntity xml: (value process: request)) ] .	
	].
	server delegate: delegate.
	server start
	
	"(HttpService servicesNamed: 'test123') 
		ifEmpty: [ start; setDebugMode.
			(Delay forMilliseconds: 5) wait.
			newServer := true]"
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerEchoTest >> tearDown [
	server stop.
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerEchoTest >> testThroughClient [
" bring in tests here independently in next version.. for now just reuse the XMLRPCTests"

 | client |
client := XMLRPCTest suite.
client run.

	

]
