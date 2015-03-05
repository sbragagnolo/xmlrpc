"
Domain representation where all the objects that go through are usable as the service and not as it description.
"
Class {
	#name : #MDDSDomain,
	#superclass : #MDDSProtoDomain,
	#instVars : [
		'protocols',
		'createdTopics',
		'announcer'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #adding }
MDDSDomain >> addProtocol: aProtocolImplementation [
	protocols add: aProtocolImplementation
]

{ #category : #abstract }
MDDSDomain >> createPublicationFor: aMDDSDomainParticipant with: aType [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MDDSDomain >> createSubscriptionFor: aParticipant [
	^ MDDSSubscription defaultForParticipant: aParticipant.
]

{ #category : #'as yet unclassified' }
MDDSDomain >> createTopicNamed: aName type: aType [
	^ createdTopics at: aName , aType name ifAbsentPut: [ MDDSTopic domain: self name: aName type: aType ]
]

{ #category : #'as yet unclassified' }
MDDSDomain >> createTypeNamed: aName definedBy: aDefinition [
	^ MDDSType
		domain: self
		name: aName
		marshaller: aDefinition typeBuilder buildTypeMarshaller
		md5sum: aDefinition md5sum
]

{ #category : #'as yet unclassified' }
MDDSDomain >> createTypePlaceHolder:aName [
	^ MDDSTypePlaceHolder domain: self name: aName
]

{ #category : #accessing }
MDDSDomain >> destroy [
	createdTopics values
		do: [ :t | 
			t hasPublications
				ifTrue: [ t publisher stopPublishing ].
			t hasSubscriptions
				ifTrue: [ t subscriber unregisterAll  ].
			t domain: nil.
			t type domain: nil ].
	createdTopics removeAll.
	protocols removeAll.
	announcer := nil
]

{ #category : #'as yet unclassified' }
MDDSDomain >> findOrRegisterTopicByName: aName [
	^ self findOrRegisterTopicByName: aName type: MDDSTypeDescriptor unknownWildcard
]

{ #category : #'as yet unclassified' }
MDDSDomain >> findOrRegisterTopicByName: aName type: aTypeName [
	| found typeDesc |
	typeDesc := MDDSTypeDescriptor domain: self name: aTypeName.
	found := self
		findTopicByName: aName
		ifNone: [ (MDDSTopicDescriptor domain: self name: aName type: typeDesc) createTopic ].
	((typeDesc describes: found type) not and: [ found type isTypePlaceHolder ])
		ifTrue: [ found type: typeDesc createType ].
	^ found
]

{ #category : #initialization }
MDDSDomain >> initialize [
	super initialize.
	protocols := Set new.
	createdTopics := Dictionary new.
	announcer := Announcer new.
	
	self when: MDDSIsPublishingAnnouncement send: #notePublication: to: self. 
	self when: MDDSIsNotPublishingAnnouncement send: #notePublicationFinished: to: self. 
	self when: MDDSIsSubscribedAnnouncement send: #noteSubscription: to: self. 
	self when: MDDSIsNotSubscribedAnnouncement send: #noteSubscriptionFinished: to: self. 

]

{ #category : #'as yet unclassified' }
MDDSDomain >> note: anAnnouncement [
	announcer announce: anAnnouncement.
]

{ #category : #accessing }
MDDSDomain >> protocols [	
	^ protocols
]

{ #category : #'announcer handling' }
MDDSDomain >> when: anEventSelector do: aBlockClosure [ 
	announcer weak when: anEventSelector do: aBlockClosure 
]

{ #category : #'events-registering' }
MDDSDomain >> when: anEventSelector send: aMessage to: anObject [
	announcer weak when: anEventSelector send: aMessage to: anObject
]
