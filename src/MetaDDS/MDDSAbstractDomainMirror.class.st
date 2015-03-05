"
The domain mirror is a class the describes the current domain of data delivering 
"
Class {
	#name : #MDDSAbstractDomainMirror,
	#superclass : #MDDSProtoDomain,
	#instVars : [
		'domain'
	],
	#category : #'MetaDDS-Reflection'
}

{ #category : #accessing }
MDDSAbstractDomainMirror >> domain [
	^ domain
]

{ #category : #accessing }
MDDSAbstractDomainMirror >> domain: aDomain [	
	domain := aDomain.
]

{ #category : #parameters }
MDDSAbstractDomainMirror >> findTopicDescriptorByName: aName ifFound: aFoundBlock ifNone: aBlock [
	^ self topics detect: [ :t | t name = aName ] ifFound: aFoundBlock ifNone: aBlock
]

{ #category : #parameters }
MDDSAbstractDomainMirror >> findTopicDescriptorByName: aName ifNone: aBlock [
	^ self topics detect: [ :t | t name = aName ] ifNone: aBlock
]

{ #category : #parameters }
MDDSAbstractDomainMirror >> findTopicDescriptorsByName: aName [
	^ self findTopicDescriptorByName: aName ifNone: [ MDDSError signal: 'There is not topic named ' , aName ]
]

{ #category : #accessing }
MDDSAbstractDomainMirror >> reflectParticipant: aDomainParticipant [
	self subclassResponsibility.
]
