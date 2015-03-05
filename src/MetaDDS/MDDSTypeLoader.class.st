"
A MDDSTypeLoder in an object for loading types format for connections.
"
Class {
	#name : #MDDSTypeLoader,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> initialize [
	registry := Dictionary new.
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> loadTypeDefinitionNamed: aName definedFromString: aStringDefinition [
	| definition |
	definition := STON reader
		on: aStringDefinition readStream;
		next.
	self registerTypeDefinition: definition.
	^ definition
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> plainTypeDefinitionFor: aType [
	
	^ String
		streamContents: [ :stream | 
			STON writer
				on: stream;
				nextPut: (self typeDefinition: aType name) ]
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> privateRegisterTypeDefinition: aMDDSTypeDefinition [

	registry at: aMDDSTypeDefinition name put: aMDDSTypeDefinition.
	^aMDDSTypeDefinition
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> registerTypeDefinition: aMDDSTypeDefinition [
	^ aMDDSTypeDefinition beRegisteredBy: self.
	
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> typeDefinition: aTypeId [
	^ self typeDefinition: aTypeId ifAbsent: [ self error: ' There is no type named ' , aTypeId]
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> typeDefinition: aTypeName ifAbsent: aBlock [
	^ registry at: aTypeName ifAbsent: aBlock.
]

{ #category : #'as yet unclassified' }
MDDSTypeLoader >> unload [
	registry removeAll.
]
