"
A proto domain is not a Domain nor a DomainMirror. Is the base of both.
"
Class {
	#name : #MDDSProtoDomain,
	#superclass : #Object,
	#category : #'MetaDDS-Kernel'
}

{ #category : #abstract }
MDDSProtoDomain >> asString [
	^ 'DDS-Domain'
]

{ #category : #querying }
MDDSProtoDomain >> findTopicByName: aName [
	^ self findTopicByName: aName ifNone: [ MDDSError signal: 'There is not topic named ' , aName ]
]

{ #category : #querying }
MDDSProtoDomain >> findTopicByName: aName ifFound: aFoundBlock ifNone: aBlock [
	^ self topics detect: [ :t | t name = aName ] ifFound: aFoundBlock ifNone: aBlock
]

{ #category : #querying }
MDDSProtoDomain >> findTopicByName: aName ifNone: aBlock [
	^ self topics detect: [ :t | t name = aName ] ifNone: aBlock
]

{ #category : #abstract }
MDDSProtoDomain >> isTypeDefined: aTypeName [
	self typeDefinition: aTypeName ifAbsent: [ ^ false ].
	^ true.
]

{ #category : #abstract }
MDDSProtoDomain >> loadTypeDefinitionNamed: aName definedFromString: aStringDefinition [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MDDSProtoDomain >> notePublication: aMDDSIsPublishingAnnouncement [

]

{ #category : #'as yet unclassified' }
MDDSProtoDomain >> notePublicationFinished: aMDDSIsNotPublishingAnnouncement [ 

]

{ #category : #'as yet unclassified' }
MDDSProtoDomain >> noteSubscription: aMDDSIsSubscribedAnnouncement [ 

]

{ #category : #'as yet unclassified' }
MDDSProtoDomain >> noteSubscriptionFinished: aMDDSIsNotSubscribedAnnouncement [ 
]

{ #category : #abstract }
MDDSProtoDomain >> participants [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSProtoDomain >> plainTypeDefinitionFor: aType [
	self subclassResponsibility.
]

{ #category : #abstract }
MDDSProtoDomain >> subscriberFor: aTopic [
	^ MDDSSubscriber domain: self named: aTopic name , '-subscriber' on: aTopic
]

{ #category : #abstract }
MDDSProtoDomain >> topics [
	self subclassResponsibility
]

{ #category : #abstract }
MDDSProtoDomain >> typeDefinition: aTypeName [
	^ self typeDefinition: aTypeName ifAbsent: [  self error: ' There is no type named ' , aTypeName ]
]

{ #category : #abstract }
MDDSProtoDomain >> typeDefinition: aTypeName ifAbsent: aBlock [
	^self subclassResponsibility 
]
