"
part of the dds architecutre includes for connection details, and, as well, support to several kind of IP based protocols. 
"
Class {
	#name : #MDDSConnectionDescription,
	#superclass : #Object,
	#instVars : [
		'participant',
		'topicInteractor'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSConnectionDescription >> itIsSupportedBy: aProtocol [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSConnectionDescription >> latching [
	^ '0'.
]

{ #category : #accessing }
MDDSConnectionDescription >> participant [
	^ participant.
]

{ #category : #accessing }
MDDSConnectionDescription >> participant: aParticipantMirror [
	 participant := aParticipantMirror.
]

{ #category : #accessing }
MDDSConnectionDescription >> topic [
	^ topicInteractor topic
]

{ #category : #accessing }
MDDSConnectionDescription >> topicInteractor [
	^ topicInteractor
]

{ #category : #accessing }
MDDSConnectionDescription >> topicInteractor: anObject [
	topicInteractor := anObject
]

{ #category : #'as yet unclassified' }
MDDSConnectionDescription >> validateAndProcessHeader: aHeader [
	^ (self topic name = aHeader topic and: [ self topic type verify: aHeader type md5: aHeader md5sum ])
		ifTrue: [ 
			self topic noticeConnectionWith: aHeader.
			true ]
		ifFalse: [ false ]
]
