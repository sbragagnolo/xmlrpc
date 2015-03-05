"
ARemote domain is a domain known for being defined externally to the image.
"
Class {
	#name : #MDDSExternallyDefinedDomain,
	#superclass : #MDDSDomain,
	#instVars : [
		'mirror'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #constructor }
MDDSExternallyDefinedDomain class >> on: aMirror [
	| domain |
	domain := self new. 
	domain mirror: aMirror.
	aMirror domain: domain.
	^ domain.
]

{ #category : #abstract }
MDDSExternallyDefinedDomain >> createPublicationFor: aMDDSDomainParticipant with: aType [
	^ mirror createPublicationFor: aMDDSDomainParticipant with: aType.
]

{ #category : #abstract }
MDDSExternallyDefinedDomain >> destroy [
	super destroy.
	mirror
		ifNotNil: [ 
			mirror destroy.
			mirror := nil ]
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> isRegistered: aMDDSTopic [
	^ mirror
		findTopicByName: aMDDSTopic name
		ifFound: [ :topic | topic type name = aMDDSTopic type name ]
		ifNone: [ false ]
]

{ #category : #abstract }
MDDSExternallyDefinedDomain >> loadTypeDefinitionNamed: aName definedFromString: aStringDefinition [
	^ mirror loadTypeDefinitionNamed: aName definedFromString: aStringDefinition
]

{ #category : #accessing }
MDDSExternallyDefinedDomain >> mirror [
	^ mirror
]

{ #category : #accessing }
MDDSExternallyDefinedDomain >> mirror: aDomainMirror [
	mirror := aDomainMirror.
	
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> notePublication: aMDDSIsPublishingAnnouncement [
	mirror notePublication: aMDDSIsPublishingAnnouncement
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> notePublicationFinished: aMDDSIsNotPublishingAnnouncement [
	mirror notePublicationFinished: aMDDSIsNotPublishingAnnouncement.
	(aMDDSIsNotPublishingAnnouncement publication) destroy.
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> noteSubscription: aMDDSIsSubscribedAnnouncement [
	mirror noteSubscription: aMDDSIsSubscribedAnnouncement
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> noteSubscriptionFinished: aMDDSIsNotSubscribedAnnouncement [ 
	mirror noteSubscriptionFinished: aMDDSIsNotSubscribedAnnouncement.
	(aMDDSIsNotSubscribedAnnouncement subscription) destroy.
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> obtainPort [
	^ mirror obtainPort.
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> participants [
	^ mirror participants
]

{ #category : #abstract }
MDDSExternallyDefinedDomain >> plainTypeDefinitionFor: aType [
	^ mirror plainTypeDefinitionFor: aType
]

{ #category : #abstract }
MDDSExternallyDefinedDomain >> registerTypeDefinition: aMDDSTypeDefinition [
	^ mirror registerTypeDefinition: aMDDSTypeDefinition
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> subscriberFor: aTopic [
	^ mirror subscriberFor: aTopic
]

{ #category : #'as yet unclassified' }
MDDSExternallyDefinedDomain >> topics [
	^ mirror topics collect: #createTopic
]

{ #category : #abstract }
MDDSExternallyDefinedDomain >> typeDefinition: typeName ifAbsent: aBlock [
	^ mirror typeDefinition: typeName ifAbsent: aBlock
]
