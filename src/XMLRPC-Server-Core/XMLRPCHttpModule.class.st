"
This comanche module handles incoming requests for a XMLRPC server
"
Class {
	#name : #XMLRPCHttpModule,
	#superclass : #Object,
	#instVars : [
		'services'
	],
	#classInstVars : [
		'defaultModule',
		'port',
		'service'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #construction }
XMLRPCHttpModule class >> for: aServiceDefinition [ 
	^ self new services: aServiceDefinition ; yourself.
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
	| xmldoc  parameters service response  |
	
	[
		xmldoc := XMLDOMParser parse: (request contents) readStream.		
		service := self resolveServiceName: xmldoc.
		parameters := self resolveParameters: xmldoc.
		response :=  (service = 'system.multicall') ifTrue: [
			(parameters at:1) collect: [ : i | 
				| s p |
				s :=  i at:'methodName'  .
				p := i at: 'params'.
				self invoke: s with: p. 	
			]
		] ifFalse: [ 
			self invoke: service with: parameters . 	
		 ].
		response := self returnableResponse: response.
		
	] on: Error do:[ 
		:e |
		 response := (XMLRPCErrorHandler new error: e) errorMessage.
	].
	^ response.
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
	
	
	^ stream contents.
	
]

{ #category : #accessing }
XMLRPCHttpModule >> services: aServiceDefinition [
	services := aServiceDefinition asDictionary.
]
