"
Any entity that has to do with the domain, has a domain and name for sure. 
"
Class {
	#name : #MDDSEntity,
	#superclass : #Object,
	#instVars : [
		'domain',
		'name'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSEntity class >> domain: aDomain name: aName [
	^ self new name: aName ; domain: aDomain; yourself.
]

{ #category : #'as yet unclassified' }
MDDSEntity class >> named: aName [
	^ self new name: aName ;yourself.
]

{ #category : #'as yet unclassified' }
MDDSEntity >> asString [
	^ self class name,  '  ', name.
]

{ #category : #'as yet unclassified' }
MDDSEntity >> domain [
	^ domain
]

{ #category : #accessing }
MDDSEntity >> domain: aDDSDomain [
	domain := aDDSDomain.
]

{ #category : #accessing }
MDDSEntity >> name [
	^ name.
]

{ #category : #accessing }
MDDSEntity >> name: aTopicName [
	name := aTopicName.
]

{ #category : #'as yet unclassified' }
MDDSEntity >> printOn: aStream [
	self asString printOn: aStream
]
