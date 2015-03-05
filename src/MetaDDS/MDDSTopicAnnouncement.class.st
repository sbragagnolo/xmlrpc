"
Topic are continuously havign changes, new publishers, subscribers, subcriptions, messages. 
Many of the updates are needed by several kinds of objects of different kinds. Then this changes are announced insted of queried.
"
Class {
	#name : #MDDSTopicAnnouncement,
	#superclass : #MDDSAnnouncement,
	#instVars : [
		'topic'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSTopicAnnouncement class >> participant: aParticipant isNotPublishingAnymoreOn: aPublisher through: aPublication [
	^ MDDSIsNotPublishingAnnouncement participant: aParticipant publisher: aPublisher publication: aPublication.
	
]

{ #category : #'as yet unclassified' }
MDDSTopicAnnouncement class >> participant: aParticipant isNotSubscribedAnymoreTo: aSubscriber with: aSubscription [
	^ MDDSIsNotSubscribedAnnouncement participant: aParticipant subscriber: aSubscriber subscription: aSubscription
]

{ #category : #'as yet unclassified' }
MDDSTopicAnnouncement class >> participant: aParticipant isNowPublishingOn: aPublisher through: aPublication [
	^ MDDSIsPublishingAnnouncement participant: aParticipant publisher: aPublisher publication: aPublication.
]

{ #category : #'as yet unclassified' }
MDDSTopicAnnouncement class >> participant: aParticipant isNowSubscribedTo: aSubscriber with: aSubscription [
	^ MDDSIsSubscribedAnnouncement participant: aParticipant subscriber: aSubscriber subscription: aSubscription
]

{ #category : #'as yet unclassified' }
MDDSTopicAnnouncement class >> topic: aTopic [
	^ self new topic: aTopic; yourself
]

{ #category : #accessing }
MDDSTopicAnnouncement >> topic [
	^ topic
]

{ #category : #accessing }
MDDSTopicAnnouncement >> topic: anObject [
	topic := anObject
]
