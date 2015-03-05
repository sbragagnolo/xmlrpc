"
A PhaROSUInt16Type  is a 16 bits represetnation of unsigned int 
"
Class {
	#name : #MDDSUInt16Type,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSUInt16Type class >> alterName [
	^ #UInt16
]

{ #category : #accessing }
MDDSUInt16Type class >> dataTypeSize [
	^ 2
]

{ #category : #serialize }
MDDSUInt16Type >> decode: aFLDecoder [ 
	[
		^ aFLDecoder nextEncodedUint16.
	] on: Error do: [
		self signal: 'cannot load value'.
	].
]

{ #category : #testing }
MDDSUInt16Type >> isAPossibleValue: aNumber [
	^(aNumber isKindOf: Number) and:[ aNumber >= 0 and: [ aNumber < 65536]].
	
]

{ #category : #serialize }
MDDSUInt16Type >> newInstance [ 
	^ 0.
]

{ #category : #'as yet unclassified' }
MDDSUInt16Type >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedUInt16.
	encodeSelector := #encodeUint16:.
	 
	
	
]

{ #category : #'as yet unclassified' }
MDDSUInt16Type >> typeName [ 
	^ 'uint16'
]
