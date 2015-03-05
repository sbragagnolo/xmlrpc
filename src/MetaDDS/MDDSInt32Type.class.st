"
A PhaROSInt32Type  is a 32 bits represetnation of int 
"
Class {
	#name : #MDDSInt32Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSInt32Type class >> alterName [
	^ #Int32
]

{ #category : #accessing }
MDDSInt32Type class >> dataTypeSize [
	^ 4
]

{ #category : #testing }
MDDSInt32Type >> isAPossibleValue: aNumber [
	^(aNumber isKindOf: Number )and: [
		aNumber >	-2147483649 and: [ aNumber  < 2147483648 ]
	]

]

{ #category : #'as yet unclassified' }
MDDSInt32Type >> newInstance [ 
	^ 0.
]

{ #category : #initializing }
MDDSInt32Type >> setEncodeDecodeSelectors [
	decodeSelector := #nextEncodedInt32.
	encodeSelector := #encodeInt32:.
]

{ #category : #initializing }
MDDSInt32Type >> typeName [ 
	^ 'int32'
]
