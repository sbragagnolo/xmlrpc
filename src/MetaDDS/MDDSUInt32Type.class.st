"
A PhaROSUInt32Type   is a 32 bits represetnation of unsigned int 
"
Class {
	#name : #MDDSUInt32Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSUInt32Type class >> alterName [
	^ #UInt32
]

{ #category : #accessing }
MDDSUInt32Type class >> dataTypeSize [
	^ 4
]

{ #category : #serialize }
MDDSUInt32Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedUint32 
]

{ #category : #testing }
MDDSUInt32Type >> isAPossibleValue: aValue [ 
	^ (aValue isKindOf: Number )and:[ aValue >= 0  and:[ aValue <  4294967296]] .
]

{ #category : #serialize }
MDDSUInt32Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
MDDSUInt32Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUint32.
	encodeSelector := #encodeUint32:.
	

]

{ #category : #'as yet unclassified' }
MDDSUInt32Type >> typeName [ 
	^ 'int32'
]
