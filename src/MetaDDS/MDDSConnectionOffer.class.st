"
part of the dds architecutre includes a offers for connection, and, as well, support to several kind of IP based protocols
"
Class {
	#name : #MDDSConnectionOffer,
	#superclass : #MDDSConnectionDescription,
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSConnectionOffer class >> publisher: aPublisher participant: aParticipantMirror [ 
	^ self new topicInteractor: aPublisher; participant: aParticipantMirror ;yourself 
]

{ #category : #'as yet unclassified' }
MDDSConnectionOffer >> itIsSupportedBy: aProtocol [
	^ participant protocols anySatisfy: [ :p | p name = aProtocol name ]
]
