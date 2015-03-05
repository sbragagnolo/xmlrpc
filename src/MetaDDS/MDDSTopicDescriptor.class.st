"
A MDDSTopicDescriptor is description that defines a topic. Name, type, etc. It allows also to create a topic.
"
Class {
	#name : #MDDSTopicDescriptor,
	#superclass : #MDDSEntity,
	#instVars : [
		'type'
	],
	#category : #'MetaDDS-Reflection'
}

{ #category : #constructor }
MDDSTopicDescriptor class >> domain: aDomain name: aName type: aTypeName [ 
	^ self new name: aName; type: aTypeName;  domain: aDomain ; yourself.
]

{ #category : #constructor }
MDDSTopicDescriptor class >> name: aName type: aTypeName [ 
	^ self new name: aName; type: aTypeName; yourself.
]

{ #category : #'as yet unclassified' }
MDDSTopicDescriptor >> asString [
	^ '{1}:{2}@{3}'
		format:
			{name.
			type.
			' domain'}
]

{ #category : #'as yet unclassified' }
MDDSTopicDescriptor >> createTopic [
	^ domain createTopicNamed: name type: type createType
]

{ #category : #accessing }
MDDSTopicDescriptor >> domain: aDomain [
	type domain: aDomain.
	^ super domain: aDomain
]

{ #category : #'as yet unclassified' }
MDDSTopicDescriptor >> participants [
	self shouldBeImplemented.
]

{ #category : #accessing }
MDDSTopicDescriptor >> topic [
	^ self
]

{ #category : #accessing }
MDDSTopicDescriptor >> type [
	^ type
]

{ #category : #accessing }
MDDSTopicDescriptor >> type: aTopicType [
	type := aTopicType
]
