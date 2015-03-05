"
A PhaROSUInt8Type   is a 8 bits represetnation of unsigned int 
"
Class {
	#name : #MDDSUInt8Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSUInt8Type class >> alterName [
	^ #UInt8
]

{ #category : #accessing }
MDDSUInt8Type class >> dataTypeSize [ 
	^ 1
]

{ #category : #serialize }
MDDSUInt8Type class >> unserialize: aByteArray [
	self assert: aByteArray size = 1.
	^ self value: (aByteArray at: 1); yourself.
]

{ #category : #serialize }
MDDSUInt8Type >> decode: aFLDecoder [
	^ aFLDecoder nextEncodedByte.
]

{ #category : #testing }
MDDSUInt8Type >> isAPossibleValue: aValue [
	^ (aValue isKindOf: Number) and: [
		aValue >= 0 and:[ aValue < 256 ]
	].
	
]

{ #category : #serialize }
MDDSUInt8Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
MDDSUInt8Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUint8.
	encodeSelector := #encodeUint8:.
	
]

{ #category : #'as yet unclassified' }
MDDSUInt8Type >> typeName [ 
	^ 'int8'
]
