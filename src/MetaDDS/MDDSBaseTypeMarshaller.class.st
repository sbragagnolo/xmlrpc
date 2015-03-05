"
A PhaROSType is abstract representation of type
"
Class {
	#name : #MDDSBaseTypeMarshaller,
	#superclass : #Object,
	#instVars : [
		'encodeSelector',
		'decodeSelector'
	],
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSBaseTypeMarshaller class >> constant: aTypeName value: aValue [ 
	^ MDDSConstantDefinition name: aTypeName typedAs: self new withValue: aValue.
]

{ #category : #private }
MDDSBaseTypeMarshaller class >> forPhaROSTyping [
	^ self
]

{ #category : #'pseudo-dsl' }
MDDSBaseTypeMarshaller class >> initialize [ 	
	super initialize.
	self = MDDSBaseTypeMarshaller ifFalse: [
		self registerAlterName.
	]
]

{ #category : #'pseudo-dsl' }
MDDSBaseTypeMarshaller class >> registerAlterName [
	Smalltalk at: self alterName put: self.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> check: aValue [

	(self isAPossibleValue: aValue ) ifFalse:[ PhaROSUnexpextedValue signal: 'Unexpected value'].
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> constantValue: aValue [
	^ aValue.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> dataTypeSize [
	^ self class dataTypeSize.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> dataTypeSizeFor: aValue [
	^ self dataTypeSize.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> decode: aDecoder [

	^ aDecoder perform: decodeSelector.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> decodeSelector [ 
	^decodeSelector.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> defaultValueString [
	^ self newInstance asString.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> encodeSelector [ 
	^ encodeSelector.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> initialize [ 
	self setEncodeDecodeSelectors.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> isAPossibleSize: aSize [
	^ aSize = self dataTypeSize.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> isCollectionType [
	^ false
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> newInstance [
	^ Array new.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> newPacket [
	^ PhaROSPacket type: self value: self newInstance.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> serialize:aValue into: anEncoder [
	^ anEncoder perform: encodeSelector with: aValue.
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> typeName [
	^ self subclassResponsibility 
]

{ #category : #accessing }
MDDSBaseTypeMarshaller >> unserialize: aStream [
	| decoder aByteArray | 
	
	aByteArray  := aStream next: self dataTypeSize.
	
	aByteArray size = self dataTypeSize ifFalse: [
		PhaROSUnexpextedValue signal:' Unexpected Value'.
	].

	decoder := MDDSDecoder on: (ReadStream on: aByteArray).
	self decode: decoder. 
	
	
]
