"
A PhaROSInt64Type  is a 64 bits represetnation of int 
"
Class {
	#name : #MDDSInt64Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSInt64Type class >> alterName [
	^ #Int64
]

{ #category : #accessing }
MDDSInt64Type class >> dataTypeSize [
	^ 8
]

{ #category : #testing }
MDDSInt64Type >> isAPossibleValue: aNumber [
	^( aNumber isKindOf: Number )and: [
		aNumber > -9223372036854775809  and: [ aNumber <  9223372036854775808].
	]
	
]

{ #category : #'as yet unclassified' }
MDDSInt64Type >> newInstance [ 
	^ 0.
]

{ #category : #initialize }
MDDSInt64Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt64.
	encodeSelector := #encodeInt64:.
	

]

{ #category : #initialize }
MDDSInt64Type >> typeName [ 
	^ 'int64'
]
