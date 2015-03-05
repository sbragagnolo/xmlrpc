"
All remote domain mirrors are related with a proxy. This proxy is meant to be a proxy  adaptor. The idea is to subclass this class, and use a proxy. The used proxy can have what ever it takes and needs to implement the comunicaiton. Meanwhile the adapter proxy(subclass) needs to respond to a known protocol.
"
Class {
	#name : #MDDSAbstractDomainProxy,
	#superclass : #Object,
	#category : #'MetaDDS-Proxy'
}

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> createPublicationFor: aMDDSDomainParticipant with: aType [
	^ self subclassResponsibility 
]

{ #category : #abstract }
MDDSAbstractDomainProxy >> destroy [
	" nothing to do here "
	
]

{ #category : #abstract }
MDDSAbstractDomainProxy >> loadTypeDefinitionNamed: aName definedFromString: aStringDefinition [
	self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> obtainPort [
	self subclassResponsibility 
]

{ #category : #abstract }
MDDSAbstractDomainProxy >> participants [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> plainTypeDefinitionFor: aType [
]

{ #category : #accessing }
MDDSAbstractDomainProxy >> reflectParticipant: aMDDSParticipant [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> registerTopicPublisher: aPublisher for: aParticipant in: aDomain [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> registerTopicSubscriber: aSubscriber for: aParticipant in: aDomain [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> subscriberFor: aTopic in: aDomain [
	self subclassResponsibility 
]

{ #category : #abstract }
MDDSAbstractDomainProxy >> topics [
	self subclassResponsibility 
]

{ #category : #abstract }
MDDSAbstractDomainProxy >> typeDefinition: aString [ 
	^ self typeDefinition: aString  ifAbsent: [ self error: 'There is not type named ', aString ]
]

{ #category : #abstract }
MDDSAbstractDomainProxy >> typeDefinition: aString ifAbsent: aBlock [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> unregisterTopicPublisher: aPublisher for: aParticipant [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MDDSAbstractDomainProxy >> unregisterTopicSubscriber: aSubscriber for: aParticipant [
	self subclassResponsibility 
]
