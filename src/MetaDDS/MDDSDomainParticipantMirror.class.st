"
This class is the decription of a participant in our system in terms of communication: name, ip/port, etc
"
Class {
	#name : #MDDSDomainParticipantMirror,
	#superclass : #MDDSEntity,
	#instVars : [
		'participant'
	],
	#category : #'MetaDDS-Reflection'
}

{ #category : #constructor }
MDDSDomainParticipantMirror class >> domain: aDomain name: aName participant: aMDDSParticipant [
	^ (self domain: aDomain name: aName )participant: aMDDSParticipant ; yourself.
]

{ #category : #accessing }
MDDSDomainParticipantMirror >> domain [
	^ participant domain
]

{ #category : #accessing }
MDDSDomainParticipantMirror >> participant [
	^ participant
]

{ #category : #accessing }
MDDSDomainParticipantMirror >> participant: aMDDSDomainParticipant [ 
	participant := aMDDSDomainParticipant
]

{ #category : #accessing }
MDDSDomainParticipantMirror >> protocols [ 
	^ participant protocols
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipantMirror >> publicationForTopic: aTopic [
	^ aTopic publications detect: [ :s | s participant = participant ]. 
	
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipantMirror >> publicationForTopicNamed: aTopicName [
	^ self publicationForTopic: (participant domain findTopicByName: aTopicName)
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipantMirror >> publications [
	^ participant domain topics
		inject: Set new
		into: [ :set :topic | 
			set addAll: (topic publications select: [ :s | s participant = participant ]).
			set ]
]

{ #category : #accessing }
MDDSDomainParticipantMirror >> publishedTopics [
	^ participant domain topics select: [ :t | t publications anySatisfy: [ :s | s participant = participant ] ]
]

{ #category : #accessing }
MDDSDomainParticipantMirror >> subscribedTopics [
	^ participant domain topics select: [ :t | t subscriptions anySatisfy: [ :s | s participant = participant ] ]
]
