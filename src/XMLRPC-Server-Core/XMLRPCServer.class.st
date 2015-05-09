Class {
	#name : #XMLRPCServer,
	#superclass : #Object,
	#instVars : [
		'port',
		'server',
		'modules'
	],
	#classInstVars : [
		'DefaultClass'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #construction }
XMLRPCServer class >> defaultClass [ 
	^ DefaultClass.
]

{ #category : #construction }
XMLRPCServer class >> defaultClass: aClass [ 
	DefaultClass := aClass.
]

{ #category : #construction }
XMLRPCServer class >> initialize [
	self defaultClass: XMLRPCZNServer
]

{ #category : #'as yet unclassified' }
XMLRPCServer class >> startOn: aPort with: aModuleDictinaryDefinition [
	^ self startOn: aPort with: aModuleDictinaryDefinition at: '/'

]

{ #category : #construction }
XMLRPCServer class >> startOn: aPort with: aModuleDictinaryDefinition at: anAlias [
	^ self defaultClass new port: aPort; at: anAlias put: aModuleDictinaryDefinition ; start ; yourself.


]

{ #category : #accessing }
XMLRPCServer >> addModules: aModuleDefinition [ 
	modules := modules union: aModuleDefinition asDictionary.
]

{ #category : #accessing }
XMLRPCServer >> at: uri put: aModule [

	modules at: uri put: aModule.
]

{ #category : #accessing }
XMLRPCServer >> createServer [ 
	^ self subclassResponsibility.
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

	server ifNil:[	self createServer ].
	server start.
	
	
]

{ #category : #control }
XMLRPCServer >> stop [
	self subclassResponsibility.
]
