Class {
	#name : #XMLRPCZNServerEchoTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'test support' }
XMLRPCZNServerEchoTest >> addTests [
	"XMLRPCStandardEcho addTests"

	XMLRPCServerRequest registerService: 'echo.echoArray' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoBinary' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoBoolean' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoDateTime' class: self  selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoDouble' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoInt' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoString' class: self selector: #echo:.
	XMLRPCServerRequest registerService: 'echo.echoStruct' class: self selector: #echo:
]

{ #category : #'test support' }
XMLRPCZNServerEchoTest >> echo: aValue [

   ^aValue first
]

{ #category : #running }
XMLRPCZNServerEchoTest >> setUp [
	| delegate |

	XMLRPCServer defaultClass: XMLRPCZNServer.
	self addTests.

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

{ #category : #running }
XMLRPCZNServerEchoTest >> tearDown [
	server stop.
]

{ #category : #tests }
XMLRPCZNServerEchoTest >> testThroughClient [
" bring in tests here independently in next version.. for now just reuse the XMLRPCTests"

 | client |
client := XMLRPCTest suite.
client run.

	

]
