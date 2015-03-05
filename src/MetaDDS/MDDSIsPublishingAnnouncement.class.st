"
A MDDSIsPublishingAnnouncement announces that a participant is about to start publishing information in a topic. 
"
Class {
	#name : #MDDSIsPublishingAnnouncement,
	#superclass : #MDDSTopicAnnouncement,
	#instVars : [
		'participant',
		'publisher',
		'publication'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSIsPublishingAnnouncement class >> participant: aParticipant publisher: aPublisher publication: aPublication [
	^ (self topic: aPublisher topic) participant: aParticipant; publisher: aPublisher; publication: aPublication; yourself.
]

{ #category : #accessing }
MDDSIsPublishingAnnouncement >> participant [
	^ participant
]

{ #category : #accessing }
MDDSIsPublishingAnnouncement >> participant: anObject [
	participant := anObject
]

{ #category : #accessing }
MDDSIsPublishingAnnouncement >> publication [
	^ publication
]

{ #category : #accessing }
MDDSIsPublishingAnnouncement >> publication: anObject [
	publication := anObject
]

{ #category : #accessing }
MDDSIsPublishingAnnouncement >> publisher [
	^ publisher
]

{ #category : #accessing }
MDDSIsPublishingAnnouncement >> publisher: anObject [
	publisher := anObject
]
