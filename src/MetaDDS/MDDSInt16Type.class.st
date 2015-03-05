"
A PhaROSInt16Type is a 16 bits represetnation of int 
"
Class {
	#name : #MDDSInt16Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSInt16Type class >> alterName [
	^ #Int16
]

{ #category : #accessing }
MDDSInt16Type class >> dataTypeSize [
	^ 2
]

{ #category : #testing }
MDDSInt16Type >> isAPossibleValue: aSmallInteger [ 
	^(aSmallInteger isKindOf: SmallInteger) and: [
		aSmallInteger > -32769 and: [  aSmallInteger < 32768 ]
	].
]

{ #category : #'as yet unclassified' }
MDDSInt16Type >> newInstance [ 
	^ 0.
]

{ #category : #initializing }
MDDSInt16Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt16.
	encodeSelector := #encodeInt16:.
]

{ #category : #initializing }
MDDSInt16Type >> typeName [ 
	^ 'int16'
]
