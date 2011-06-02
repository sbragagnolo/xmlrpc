Class {
	#name : #XMLRPCServerEchoTest,
	#superclass : #TestCase,
	#instVars : [
		'newServer'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCServerEchoTest >> setUp [
"self new setUp"
"XMLRPCHttpModule stop"
	newServer := false.
	XMLRPCStandardEcho addTests.
	(HttpService servicesNamed: 'test123') 
		ifEmpty: [XMLRPCHttpModule start; setDebugMode.
			(Delay forMilliseconds: 5) wait.
			newServer := true]
]

{ #category : #'as yet unclassified' }
XMLRPCServerEchoTest >> tearDown [
	 XMLRPCHttpModule stop 
]

{ #category : #'as yet unclassified' }
XMLRPCServerEchoTest >> testThroughClient [
" bring in tests here independently in next version.. for now just reuse the XMLRPCTests"

 | client |

client := XMLRPCTest suite.
client run.

	

]
