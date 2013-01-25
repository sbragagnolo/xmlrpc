Class {
	#name : #XMLRPCZNServerEchoTest,
	#superclass : #TestCase,
	#instVars : [
		'newServer'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCZNServerEchoTest >> setUp [
"self new setUp"
"XMLRPCHttpModule stop"
	XMLRPCServer defaultClass: XMLRPCZNServer.
	newServer := false.
	XMLRPCStandardEcho addTests.
	(HttpService servicesNamed: 'test123') 
		ifEmpty: [XMLRPCHttpModule start; setDebugMode.
			(Delay forMilliseconds: 5) wait.
			newServer := true]
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerEchoTest >> tearDown [
	 XMLRPCHttpModule stop.
	XMLRPCServer initialize.
]

{ #category : #'as yet unclassified' }
XMLRPCZNServerEchoTest >> testThroughClient [
" bring in tests here independently in next version.. for now just reuse the XMLRPCTests"

 | client |

client := XMLRPCTest suite.
client run.

	

]
