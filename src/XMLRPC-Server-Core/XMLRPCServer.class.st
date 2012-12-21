Class {
	#name : #XMLRPCServer,
	#superclass : #Object,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'port',
		'server',
		'modules'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #configuration }
XMLRPCServer class >> configurationOfLog [
	<logConfigurationAsClass: #ConfigurationOfXMLRPC >
]

{ #category : #'as yet unclassified' }
XMLRPCServer class >> startOn: aPort [
	^ self startOn: aPort with: Dictionary new.


]

{ #category : #'as yet unclassified' }
XMLRPCServer class >> startOn: aPort with: aModuleDictinaryDefinition [
	^ self new port: aPort; modules: aModuleDictinaryDefinition; start ; yourself.


]

{ #category : #construction }
XMLRPCServer class >> startOn: aPort with: aModuleDictinaryDefinition at: anAlias [
	^ self new port: aPort; at: anAlias put: aModuleDictinaryDefinition ; start ; yourself.


]

{ #category : #accessing }
XMLRPCServer >> addModules: aModuleDefinition [ 
	modules := modules union: aModuleDefinition asDictionary.
]

{ #category : #accessing }
XMLRPCServer >> at: uri put: aModule [

	modules at: uri put: aModule.
]

{ #category : #control }
XMLRPCServer >> createServer [
	| assembly |
	
		
	
	assembly := ModuleAssembly core.

	modules keysAndValuesDo: [
		:key :value | 

		self debug: [' Creating service based on HttpService on alias ', key asString ].		
		assembly alias: key to: [
			assembly addPlug: [
					:request | 	
					value process: request
			]
		].
		
	].
		
	server := HttpService on: port.
	server plug: assembly rootModule.
	

]

{ #category : #'initialize-release' }
XMLRPCServer >> destroy [
	self stop.
	server := nil.
	
]

{ #category : #'initialize-release' }
XMLRPCServer >> initialize [ 
	super initialize.
	modules := Dictionary new.
	

]

{ #category : #accessing }
XMLRPCServer >> modules: aModuleDefinition [ 
	modules := aModuleDefinition asDictionary.
	
]

{ #category : #accessing }
XMLRPCServer >> port [
	^port.
]

{ #category : #accessing }
XMLRPCServer >> port: aPort [
	port := aPort. 

]

{ #category : #control }
XMLRPCServer >> start [
	| assembly |
	server ifNil:[
		self createServer.
	].

	server start.
	
	
]

{ #category : #control }
XMLRPCServer >> stop [
	self info: ' Stopping XMLRPC Server '.
	server ifNotNil: [
		self debug: ' Unregistering service '.
		server unregister.
		server := nil
	] ifNil:[
		self debug: ' Related service is poiting to Nil '.
	].
	self info: ' XMLRPC Server stopped'.
]
