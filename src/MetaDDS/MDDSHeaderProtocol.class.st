"
The header protocol is a protocol that suits the needs of the header messanging in between connections during the handhshake of a connection.
"
Class {
	#name : #MDDSHeaderProtocol,
	#superclass : #MDDSProtocol,
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSHeaderProtocol >> initializeDecoder: aDecoder with: aTypeMarshaller [
	^ aDecoder
]
