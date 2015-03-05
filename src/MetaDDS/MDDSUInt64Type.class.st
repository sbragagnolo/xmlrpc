"
A PhaROSUInt64Type  is a 64 bits represetnation of unsigned int 
"
Class {
	#name : #MDDSUInt64Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSUInt64Type class >> alterName [
	^ #UInt64
]

{ #category : #accessing }
MDDSUInt64Type class >> dataTypeSize [
	^ 8
]

{ #category : #serialize }
MDDSUInt64Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedUint64.
]

{ #category : #testing }
MDDSUInt64Type >> isAPossibleValue: aValue [ 
	^ (aValue isKindOf: Number )and:[ aValue >= 0  and:[ aValue <  18446744073709551616]] .
]

{ #category : #serialize }
MDDSUInt64Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
MDDSUInt64Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUint64.
	encodeSelector := #encodeUint64:.
	

]

{ #category : #'as yet unclassified' }
MDDSUInt64Type >> typeName [ 
	^ 'int64'
]
