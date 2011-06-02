"
This comanche module handles incoming requests for a XMLRPC server
"
Class {
	#name : #XMLRPCHttpModule,
	#superclass : #Object,
	#classInstVars : [
		'port',
		'service'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> createServiceOnPort: aPort [
	| serv xs ma |
	Smalltalk
		at: #HttpService
		ifPresent: [:hs | 
			xs := XMLRPCHttpModule new.
			ma := ModuleAssembly core.
			ma
				alias: '/xmlrpc'
				to: [ma
						addPlug: [:request | xs process: request]].
			serv := HttpService on: aPort named: 'xmlrpcd'.
			serv plug: ma rootModule.
			^ serv].
	Smalltalk
		at: #ComancheNetService
		ifPresent: [:cns | ^ (cns named: 'xmlrpc' onPort: port)
				module: self new]
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> initialize [
	"Smalltalk addToStartUpList: self after: AutoStart."
	Smalltalk addToShutDownList: self
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> pause [
	service ifNotNil:
		[service unregister.
		service := nil]
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> setDebugMode [
	service setDebugMode.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> setDeploymentMode [
	service setDeploymentMode.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> setVerboseMode [
	service setVerboseMode.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> shutdown [
	self pause
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> start [
	^ self startOn: 8081
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startKom61 [
	^ self start
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startOn: aPort [
	self stop.
	port := aPort.
	service := self createServiceOnPort: aPort.
	service start
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startUp [
	port ifNotNil: [self startOn: port]
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> stop [
	self pause.
	port := nil.

]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule >> process: request [ 
	| xrReq |
	[xrReq := XMLRPCServerRequest
				fromRequest: (request stream next: request contentLength).
	xrReq targetURI: request url.
	^ HttpResponse
		fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: xrReq methodResponse)]
		on: Error
		do: [:e | ^ HttpResponse
				fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: (XMLRPCErrorHandler new error: e) errorMessage)]
]
