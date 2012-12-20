"
This comanche module handles incoming requests for a XMLRPC server
"
Class {
	#name : #XMLRPCHttpModule,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'services'
	],
	#classVars : [
		'defaultModule',
		'port',
		'service'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #configuration }
XMLRPCHttpModule class >> configurationOfLog [
	<logConfigurationAsClass: #ConfigurationOfXMLRPC >
]

{ #category : #construction }
XMLRPCHttpModule class >> defaultModule [
	^defaultModule ifNil: [
		defaultModule := XMLRPCHttpModule new.
		XMLRPCServerRequest receivers keysAndValuesDo:   [
			:key :value | 
			defaultModule 	registerService: key target: value key selector: value value. 
		]
	]
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> defaultPort [
	self flag: #deprecated.
	^8081.
]

{ #category : #construction }
XMLRPCHttpModule class >> for: aServiceDefinition [ 
	^ self new services: aServiceDefinition ; yourself.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> initialize [
	"Smalltalk addToStartUpList: self after: AutoStart."
	Smalltalk addToShutDownList: self
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> pause [
	self flag: #deprecated.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> setDebugMode [
	self flag: #deprecated.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> setDeploymentMode [
		self flag: #deprecated.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> setVerboseMode [
	self flag: #deprecated.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> shutdown [
	self flag: #deprecated.
	XMLRPCService stopServing: self defaultModule at: self defaultPort.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> start [
	self flag: #deprecated.
	^ self startOn: self defaultPort.
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startKom61 [
	self flag: #deprecated.
	^ self start
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startOn: aPort [
	self flag: #deprecated.
	XMLRPCService atPort: aPort serve: (self defaultModule) at:'/'
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> startUp [
	self flag: #deprecated.
	port ifNotNil: [self startOn: port]
]

{ #category : #'as yet unclassified' }
XMLRPCHttpModule class >> stop [
	self flag: #deprecated.
	self pause.
	port := nil.

]

{ #category : #logging }
XMLRPCHttpModule >> initialize [ 
	super initialize.
	services := Dictionary new.
	
]

{ #category : #private }
XMLRPCHttpModule >> invoke: aService with: anArrayOfParameters [
	| association target selector |
	association := (services at: aService).
	target := association first key.
	selector := association first value.

	[
		^ target perform: selector withArguments: anArrayOfParameters asArray.
	] on: Error do: [
		:e |
		XMLRPCMethodError new signal: 'Message not understood by server class: ', e messageText.
	]
]

{ #category : #process }
XMLRPCHttpModule >> process: request [ 
	| xmldoc  parameters service  |
	
	[
		xmldoc := XMLDOMParser parseDocumentFrom: (request rawPostFields) readStream.		
		service := self resolveServiceName: xmldoc.
		parameters := self resolveParameters: xmldoc.
		^ self returnableResponse: (self invoke: service with: parameters) . 	
	] on: Error do:[ 
		:e |
		 ^ HttpResponse fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: (XMLRPCErrorHandler new error: e) errorMessage)
	].

]

{ #category : #registering }
XMLRPCHttpModule >> registerService: serviceName target: aTarget selector: aSelector [ 
	services at: serviceName put: { aTarget -> aSelector asSymbol }.
]

{ #category : #private }
XMLRPCHttpModule >> resolveParameters: xmldoc [
	^((xmldoc firstElement) elementAt: #params ) elements inject: OrderedCollection new into: [
		:parameters :parameter |
		parameters add: (XMLRPCDecoder new decode: parameter); yourself.
	].
]

{ #category : #private }
XMLRPCHttpModule >> resolveServiceName: xmldoc [
	^ ((xmldoc firstElement elementAt: #methodName) contentString).	
]

{ #category : #private }
XMLRPCHttpModule >> returnableResponse: aResult [
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: '<?xml version="1.0"?><methodResponse><params><param>'.
	stream nextPutAll: aResult asXMLRPCString.
	stream nextPutAll: '</param></params></methodResponse>'.
	
	
	^ HttpResponse fromMIMEDocument: (MIMEDocument contentType: 'text/xml' content: stream contents )
	
]

{ #category : #accessing }
XMLRPCHttpModule >> services: aServiceDefinition [
	services := aServiceDefinition asDictionary.
]
