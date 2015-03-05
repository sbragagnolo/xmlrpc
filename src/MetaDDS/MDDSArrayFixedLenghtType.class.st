"
A PhaROSArrayFixedLenghtType is a type of fixed lenght and fixed type
"
Class {
	#name : #MDDSArrayFixedLenghtType,
	#superclass : #MDDSCollectionType,
	#instVars : [
		'size'
	],
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSArrayFixedLenghtType class >> alterName [
	^ #FixedArray
]

{ #category : #'pseudo-dsl' }
MDDSArrayFixedLenghtType class >> named: aName [
	self error: 'Fixed array need more than just name. Use #named:sized:ofType: instead'
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType class >> of: aSize of: aClass [
	^ self new size: aSize; ofClass: aClass; yourself .
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType class >> sized: aSize [
	^ self new
		size: aSize;
		yourself
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType >> defaultValueString [ 
	^ ' (OrderedCollection new: ' , size asString, ')'.
	
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType >> isAPossibleValue: aValue [
	^ (super isAPossibleValue: aValue ) and: [ aValue size = size asNumber ].
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType >> serialize:aValue into: anEncoder [
	^ anEncoder encodeFixedLenghtArray: aValue of: self relatedType.

]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType >> size: aSize [
	size := aSize asNumber.
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType >> sizeFor: aDecoder [ 
	^ size.
]

{ #category : #'as yet unclassified' }
MDDSArrayFixedLenghtType >> typeName [
	^ relatedType typeName, ('[{1}] ' format: { size })
]
