"
Real topic. This topic has the ability to act as a topic it self. Register it, ask for publishers and subscribers.
"
Class {
	#name : #MDDSTopic,
	#superclass : #MDDSEntity,
	#instVars : [
		'type',
		'subscriber',
		'publisher'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #constructor }
MDDSTopic class >> domain: aDomain name: aName type: aType [ 
	^ self new name: aName; type: aType; domain: aDomain; yourself.
]

{ #category : #constructor }
MDDSTopic class >> name: aName type: aTypeName [ 
	self halt. " Does any one use this "
	^ self new name: aName; type: aTypeName; yourself.
]

{ #category : #testing }
MDDSTopic >> hasPublications [
	^ publisher ifNil: [ false ] ifNotNil: [ self publications size > 0 ]
]

{ #category : #testing }
MDDSTopic >> hasSubscriptions [
	^ subscriber ifNil: [ false ] ifNotNil: [ self subscriptions size > 0 ]
]

{ #category : #testing }
MDDSTopic >> isRegistered [
	^ self subscriber isRegistered or: [ self publisher isRegistered ]
]

{ #category : #'as yet unclassified' }
MDDSTopic >> noticeConnectionWith: aHeader [
	type isTypePlaceHolder ifTrue: [ 
		" Is a type holder "
		type := type resolveRealTypeFrom: aHeader 	
	]
]

{ #category : #'as yet unclassified' }
MDDSTopic >> publications [
	^ publisher ifNotNil: [ publisher publications ] ifNil: [ Set new ]
]

{ #category : #creation }
MDDSTopic >> publisher [
	^ publisher ifNil: [ publisher := MDDSPublisher domain: domain named: name , '-publisher' on: self ]
]

{ #category : #subscription }
MDDSTopic >> subscriber [
	^ subscriber ifNil: [ subscriber := domain subscriberFor: self ]
]

{ #category : #'as yet unclassified' }
MDDSTopic >> subscriptions [
	^ subscriber ifNotNil: [ subscriber subscriptions ] ifNil: [ Set new ]
]

{ #category : #'as yet unclassified' }
MDDSTopic >> type [	
	^ type.
]

{ #category : #'as yet unclassified' }
MDDSTopic >> type: aType [
	type := aType
]
