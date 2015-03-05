"
a header attribute is a part of a header. Each field is represented with a a header attribute.
"
Class {
	#name : #MDDSHeaderAtribute,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'name',
		'value'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #constructor }
MDDSHeaderAtribute class >> name: aName value: aValue [
	^ self new name: aName; value: aValue; yourself.
]

{ #category : #accessing }
MDDSHeaderAtribute >> asString [
	^ '{1}={2}' format: { name . value  }.
]

{ #category : #accessing }
MDDSHeaderAtribute >> name [
	^ name
]

{ #category : #accessing }
MDDSHeaderAtribute >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MDDSHeaderAtribute >> printOn: aStream [
	self asString printOn: aStream
]

{ #category : #accessing }
MDDSHeaderAtribute >> value [
	^ value
]

{ #category : #accessing }
MDDSHeaderAtribute >> value: anObject [
	value := anObject
]
