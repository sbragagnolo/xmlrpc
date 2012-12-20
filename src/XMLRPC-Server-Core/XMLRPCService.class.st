Class {
	#name : #XMLRPCService,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'servers'
	],
	#classVars : [
		'instance'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCService class >> atPort: aPort serve: aModuleDefinition at: anAlias [
	^ self instance atPort: aPort serve: aModuleDefinition at:anAlias.

]

{ #category : #configuration }
XMLRPCService class >> configurationOfLog [
	<logConfigurationAsClass: #ConfigurationOfXMLRPC  >
]

{ #category : #loggin }
XMLRPCService class >> destroy [
	self instance destroy.
]

{ #category : #service }
XMLRPCService class >> destroy: aPort [
	^ self instance destroy: aPort.
]

{ #category : #'as yet unclassified' }
XMLRPCService class >> instance [
	^ instance ifNil: [ instance := self new. ].
	
]

{ #category : #loggin }
XMLRPCService class >> startAll [ 
	self instance startAll 
]

{ #category : #service }
XMLRPCService class >> stop: aPort [
	^ self instance stop: aPort.
]

{ #category : #loggin }
XMLRPCService class >> stopAll [
	self instance stopAll
]

{ #category : #'as yet unclassified' }
XMLRPCService >> atPort: aPort serve: aModuleDefinition at:anAlias [
	| relatedServer |
	
	relatedServer := servers at: aPort ifAbsentPut: [
		XMLRPCServer startOn: aPort with: aModuleDefinition at: anAlias.
	].


	
	
]

{ #category : #logging }
XMLRPCService >> destroy [
	self stopAll.
	servers valuesDo: #destroy.
	self initialize.
]

{ #category : #service }
XMLRPCService >> destroy: aPort [
	servers at: aPort ifPresent: [ :server | 
		server destroy.
		servers removeKey: aPort.
	].
	
]

{ #category : #'as yet unclassified' }
XMLRPCService >> initialize [ 
	super initialize.
	servers := Dictionary new.
	
]

{ #category : #'as yet unclassified' }
XMLRPCService >> start: aPort [
	servers at: aPort  ifPresent:  [
		:server | 
		server start. 
	].


]

{ #category : #'as yet unclassified' }
XMLRPCService >> startAll [
	servers valuesDo: #start.
]

{ #category : #'as yet unclassified' }
XMLRPCService >> stop: aPort [
	servers at: aPort  ifPresent:  [
		:server | 
		server stop. 
	].


]

{ #category : #'as yet unclassified' }
XMLRPCService >> stopAll [
	servers valuesDo: #stop.

]
