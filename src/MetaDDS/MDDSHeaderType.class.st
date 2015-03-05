"
A MDDSHeaderType is an special kind of type that is strictly developed for the handshake tear of the any protocol.
"
Class {
	#name : #MDDSHeaderType,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'as yet unclassified' }
MDDSHeaderType class >> alterName [
	^ #HeaderAttribute
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> calculateAttributeLength: anAttribute [
	^ 4 + anAttribute name asByteArray size + anAttribute value asByteArray size + 1.
	
" Size of the encoded size of the value
the size of the name
the size of the value
the size of the = character"
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> dataTypeSizeFor: aValue [
	^ aValue attributes inject: 0 into: [ : acc :each | acc + (self calculateAttributeLength: each) ] .
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> defaultValueString [ 
	^ ' MDDSHandshakeHeader new'.
	
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> isAPossibleValue: aValue [ 
	self shouldBeImplemented 
	
	
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> newInstance [ 
	^ MDDSHandshakeHeader new.
]

{ #category : #accessing }
MDDSHeaderType >> relatedClass [
	^ MDDSHandshakeHeader 
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> setEncodeDecodeSelectors [ 
	decodeSelector := #nextEncodedHeader.
	encodeSelector := #encodeHeader:.
	 
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> sizeFor: aDecoder [ 
	^aDecoder nextEncodedUint32.
]

{ #category : #'as yet unclassified' }
MDDSHeaderType >> typeName [ 
	^ self error: 'do not apply'.
]
