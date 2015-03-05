"
A PhaROSFloat64Type is Float 64 bits type 
"
Class {
	#name : #MDDSFloat64Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSFloat64Type class >> alterName [
	^ #Float64
]

{ #category : #accessing }
MDDSFloat64Type class >> dataTypeSize [
	^ 8
]

{ #category : #'as yet unclassified' }
MDDSFloat64Type >> decode: aFLDecoder [ 
	^ aFLDecoder nextEncodedFloat64.
]

{ #category : #'as yet unclassified' }
MDDSFloat64Type >> isAPossibleValue: aFloat [ 
	
	
	^(aFloat isKindOf: Float)
	
	
	" and: [
		aFloat = 0 or: [
			| encoder decoder stream |
			stream := WriteStream on: (ByteArray new: 4).
			encoder := PhaROSEncoder on:stream .
			encoder encodefloat32: aFloat.
			encoder flush.
			stream := ReadStream on: stream contents.
			decoder := PhaROSDecoder on: stream.
			aFloat closeTo: decoder nextEncodedFloat64
		].
	]"
]

{ #category : #'as yet unclassified' }
MDDSFloat64Type >> newInstance [ 
	^ 0.0.
]

{ #category : #'as yet unclassified' }
MDDSFloat64Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedFloat64.
	encodeSelector := #encodefloat64:.
	 
]

{ #category : #'as yet unclassified' }
MDDSFloat64Type >> typeName [ 
	^ self error: 'float64'.
]
