"
A MDDSInternallyDefinedDomain 

In this case all what goes to type definition and knowledge about existan topics, participants and its relations is defined in this image. 
"
Class {
	#name : #MDDSInternallyDefinedDomain,
	#superclass : #MDDSDomain,
	#instVars : [
		'types',
		'portResolver'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> createPublicationFor: aMDDSDomainParticipant with: aType [
	^ MDDSPublication publishing: aMDDSDomainParticipant with: aType marshaller.
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> destroy [
	super destroy.
	types
		ifNotNil: [ 
			types unload.
			types := nil ]
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> initialize [
	super initialize.
	types := MDDSTypeLoader new.
	portResolver  := MDDSPortResolver obtain
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> isRegistered: aMDDSTopic [
	^ createdTopics at: aMDDSTopic name ifPresent: [ true ] ifAbsent: [false].
	
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> loadTypeDefinitionNamed: aName definedFromString: aStringDefinition [
	^ types loadTypeDefinitionNamed: aName definedFromString: aStringDefinition
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> notePublication: aMDDSIsPublishingAnnouncement [
	| publication reading writing |
	publication := aMDDSIsPublishingAnnouncement publication.
	aMDDSIsPublishingAnnouncement topic subscriber subscriptions
		do: [ :subscription | 
			reading := MDDSReadingReferenceConnection dispatchingTo: aMDDSIsPublishingAnnouncement topic subscriber.
			reading participant: aMDDSIsPublishingAnnouncement publication participant.
			writing := MDDSWritingReferenceConnection linkedTo: reading.
			writing participant: subscription participant.
			publication register: writing.
			subscription registerConnection: reading ]
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> notePublicationFinished: aMDDSIsNotPublishingAnnouncement [
	aMDDSIsNotPublishingAnnouncement topic subscriber subscriptions
		do: [ :s | s connections removeAll: (s connections select: [ :c | c participant = aMDDSIsNotPublishingAnnouncement participant ]) ]
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> noteSubscription: aMDDSIsSubscribedAnnouncement [
	| subscription reading writing |
	subscription := aMDDSIsSubscribedAnnouncement subscription.
	aMDDSIsSubscribedAnnouncement topic publisher publications
		do: [ :publication | 
			reading := MDDSReadingReferenceConnection dispatchingTo: aMDDSIsSubscribedAnnouncement subscriber.
			reading participant: publication participant.
			writing := MDDSWritingReferenceConnection linkedTo: reading.
			writing participant: aMDDSIsSubscribedAnnouncement subscription participant.
			publication register: writing.
			subscription registerConnection: reading ]
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> noteSubscriptionFinished: aMDDSIsNotSubscribedAnnouncement [
	aMDDSIsNotSubscribedAnnouncement topic publisher publications
		do: [ :p | p connections removeAll: (p connections select: [ :c | c participant = aMDDSIsNotSubscribedAnnouncement participant] ) ].
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> obtainPort [
	^ portResolver obtainPort.
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> plainTypeDefinitionFor: aType [
	^ types plainTypeDefinitionFor: aType
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> registerTypeDefinition: aMDDSTypeDefinition [
	^ types registerTypeDefinition: aMDDSTypeDefinition
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> topics [
	^ createdTopics values
]

{ #category : #'as yet unclassified' }
MDDSInternallyDefinedDomain >> typeDefinition: typeName ifAbsent: aBlock [
	^ types typeDefinition: typeName ifAbsent: aBlock
]
