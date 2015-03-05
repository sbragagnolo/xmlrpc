"
When the domain is described in other program (server), the domain mirror points to a remote location.
"
Class {
	#name : #MDDSRemoteDomainMirror,
	#superclass : #MDDSAbstractDomainMirror,
	#instVars : [
		'proxy'
	],
	#category : #'MetaDDS-Reflection'
}

{ #category : #constructor }
MDDSRemoteDomainMirror class >> on: aDomainProxy [
	^ self new proxy: aDomainProxy ; yourself.
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> asString [
	^ super asString , (' Remote ({1})' format: {proxy})
]

{ #category : #'as yet unclassified' }
MDDSRemoteDomainMirror >> createPublicationFor: aMDDSDomainParticipant with: aType [
	^ proxy createPublicationFor: aMDDSDomainParticipant with: aType.
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> destroy [
	proxy
		ifNotNil: [ 
			proxy destroy.
			proxy := nil ]
]

{ #category : #'as yet unclassified' }
MDDSRemoteDomainMirror >> loadTypeDefinitionNamed: aName definedFromString: aStringDefinition [
	^ proxy loadTypeDefinitionNamed: aName definedFromString: aStringDefinition
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> notePublication: aMDDSIsPublishingAnnouncement [
	| mirror |
	mirror := self reflectParticipant: aMDDSIsPublishingAnnouncement participant.
	^ proxy registerTopicPublisher: aMDDSIsPublishingAnnouncement publisher for: mirror in: domain.
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> notePublicationFinished: aMDDSIsNotPublishingAnnouncement [ 
	| mirror |
	mirror := self reflectParticipant: aMDDSIsNotPublishingAnnouncement participant.
	^ proxy unregisterTopicPublisher: aMDDSIsNotPublishingAnnouncement publisher for: mirror
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> noteSubscription: aMDDSIsSubscribedAnnouncement [ 
	| mirror |
	mirror := self reflectParticipant: aMDDSIsSubscribedAnnouncement participant.
	^ proxy registerTopicSubscriber: aMDDSIsSubscribedAnnouncement subscriber for: mirror in: domain.
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> noteSubscriptionFinished: aMDDSIsNotSubscribedAnnouncement [ 
	| mirror |
	mirror := self reflectParticipant: aMDDSIsNotSubscribedAnnouncement participant.
	^ proxy unregisterTopicSubscriber: aMDDSIsNotSubscribedAnnouncement subscriber for: mirror
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> obtainMirror [
	^ proxy obtainMirror.
]

{ #category : #port }
MDDSRemoteDomainMirror >> obtainPort [
	^ proxy obtainPort.
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> participants [
	^ proxy participants
]

{ #category : #abstract }
MDDSRemoteDomainMirror >> plainTypeDefinitionFor: aType [
	^ proxy plainTypeDefinitionFor: aType
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> printOn: aStream [
	^ self asString printOn: aStream.
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> proxy: aDomainProxy [
	proxy := aDomainProxy 
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> reflectParticipant: aDomainParticipant [
	^ proxy reflectParticipant: aDomainParticipant.
]

{ #category : #abstract }
MDDSRemoteDomainMirror >> registerTypeDefinition: aMDDSTypeDefinition [
	^ proxy registerTypeDefinition: aMDDSTypeDefinition
]

{ #category : #accessing }
MDDSRemoteDomainMirror >> subscriberFor: aTopic [
	^ proxy subscriberFor: aTopic in: domain.

]

{ #category : #accessing }
MDDSRemoteDomainMirror >> topics [
	^ proxy topics do: [ :topicMirror | topicMirror domain: domain ]
]

{ #category : #abstract }
MDDSRemoteDomainMirror >> typeDefinition: aString ifAbsent: aBlock [
	^ proxy typeDefinition: aString ifAbsent: aBlock.
]
