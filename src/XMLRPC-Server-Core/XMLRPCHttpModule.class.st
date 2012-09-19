"
This comanche module handles incoming requests for a XMLRPC server
"
Class {
	#name : #XMLRPCHttpModule,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#classInstVars : [
		'port',
		'service'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> alias [
	 ^'/'.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> createServiceOnPort: aPort [
	| serv xs ma |
	Smalltalk at: #HttpService ifPresent: [
		:hs | 
		
		self debug: [' Creating service based on HttpService on alias ', self alias].
		
		xs := XMLRPCHttpModule new.
		ma := ModuleAssembly core.
		ma 	alias: self alias to: [
				ma 	addPlug: [
					:request | 
					xs process: request
				]
		].
		serv := HttpService on: aPort.
		serv plug: ma rootModule.
		^ serv
	].

	Smalltalk at: #ComancheNetService ifPresent: [
		:cns | 

		self debug: [' Creating service based on ComancheNetService on alias ', self alias].
		^ (cns named: 'xmlrpc' onPort: port) module: self new
	]
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> initialize [
	"Smalltalk addToStartUpList: self after: AutoStart."
	Smalltalk addToShutDownList: self
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> pause [
	self info: ' Stopping XMLRPC Server '.
	service ifNotNil: [
		self debug: ' Unregistering service '.
		service unregister.
		service := nil
	] ifNil:[
		self debug: ' Related service is poiting to Nil '.
	].
	self info: ' XMLRPC Server stopped'.
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
	self startOn: aPort and: nil.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startOn: aPort and: anAddress [
	self stop.
	
	self info: ['Configuring XMLRPC Server with address: ', anAddress ,' port:', aPort asString].

	port := aPort.
	service := self createServiceOnPort: aPort.
	anAddress ifNotNil:[
		service address: anAddress.
	].

	self info: ['Starting XMLRPC Server at http://', anAddress ,':', aPort asString, '/'].
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

{ #category : #process }
XMLRPCHttpModule >> process: request [ 


	self debug: 'Analyzing Request'.
	[
	 	| xrReq reqData |
		reqData := request propertyAt: #rawPostFields.
		xrReq := XMLRPCServerRequest fromRequest: reqData.
		xrReq targetURI: request url.
		^ HttpResponse fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: xrReq methodResponse)
		
	] on: Error do: [:e | 
		
		self logError: e errorMessage.
		^ HttpResponse fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: (XMLRPCErrorHandler new error: e) errorMessage)
	]
]
