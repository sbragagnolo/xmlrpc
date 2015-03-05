"
A MDDSIsSubscribedAnnouncement announces that a participant is ready to start publishing receiving information of a particular topic
"
Class {
	#name : #MDDSIsSubscribedAnnouncement,
	#superclass : #MDDSTopicAnnouncement,
	#instVars : [
		'participant',
		'subscriber',
		'subscription'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSIsSubscribedAnnouncement class >> participant: aParticipant subscriber: aSubscriber [
	^ (self topic: aSubscriber topic) participant: aParticipant; subscriber: aSubscriber; yourself.
]

{ #category : #'as yet unclassified' }
MDDSIsSubscribedAnnouncement class >> participant: aParticipant subscriber: aSubscriber subscription: aSubscription [
	^ (self topic: aSubscriber topic) participant: aParticipant; subscriber: aSubscriber; subscription: aSubscription; yourself.
]

{ #category : #accessing }
MDDSIsSubscribedAnnouncement >> participant [
	^ participant
]

{ #category : #accessing }
MDDSIsSubscribedAnnouncement >> participant: anObject [
	participant := anObject
]

{ #category : #accessing }
MDDSIsSubscribedAnnouncement >> subscriber [
	^ subscriber
]

{ #category : #accessing }
MDDSIsSubscribedAnnouncement >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #accessing }
MDDSIsSubscribedAnnouncement >> subscription [
	^ subscription
]

{ #category : #accessing }
MDDSIsSubscribedAnnouncement >> subscription: anObject [
	subscription := anObject
]
