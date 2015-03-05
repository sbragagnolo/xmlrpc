"
Object that manage the publishing to a topic. Used to publish
publisher := topic publisher.

publisher publish:  something.
publisher publish: [ : t | t fillupWith: something ].

topic publish: something.

There is just one publisher per topic in an image. It is thread safe
"
Class {
	#name : #MDDSPublisher,
	#superclass : #MDDSTopicInteractor,
	#instVars : [
		'publications'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSPublisher >> initialize [
	publications := Set new.
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> isRegistered [
	^ false.
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> obtainPort [
	^ domain obtainPort.
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> publicationFor: aParticipant ifNone: aBlock [
	^ publications detect: [ :each | each participant = aParticipant ] ifNone: aBlock
]

{ #category : #accessing }
MDDSPublisher >> publications [
	^ publications
]

{ #category : #creation }
MDDSPublisher >> publishing: aMDDSDomainParticipant [
	^ publications
		detect: [ :each | each isPublishing: aMDDSDomainParticipant ]
		ifNone: [ 
			| publication |
			publication := domain createPublicationFor: aMDDSDomainParticipant with: topic type.
			publications add: publication.
			publication noteIsRegisteredIn: self.			
			domain note: (MDDSTopicAnnouncement participant: aMDDSDomainParticipant isNowPublishingOn: self through: publication).
			publication ]
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> removePublication: aPublication [
	| announcement |
	publications remove: aPublication ifAbsent: [  ^ self  ] .
	announcement := MDDSTopicAnnouncement
		participant: aPublication participant
		isNotPublishingAnymoreOn: self
		through: aPublication.
	domain note: announcement
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> stopPublishing [
	publications do: [ :p | self stopPublishing: p ]
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> stopPublishing: aPublication [
	aPublication noteIsNotRegisteredAnymore.
	self removePublication: aPublication
]

{ #category : #'as yet unclassified' }
MDDSPublisher >> stopPublishingParticipant: aParticipant [
	| publication | 
	publication := self publicationFor: aParticipant ifNone: [ self error: ' There is no publication to stop for the given participant' ].
	self stopPublishing: publication.
]
