"
Generic part of a type definition.
"
Class {
	#name : #MDDSItemDefinition,
	#superclass : #Object,
	#instVars : [
		'name',
		'typeDefiniton'
	],
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #'as yet unclassified' }
MDDSItemDefinition class >> name: aName type: aTypeDefinition [
	^ self new name: aName; typeDefinition: aTypeDefinition; yourself.
]

{ #category : #testing }
MDDSItemDefinition >> isConstant [
	^ false
]

{ #category : #testing }
MDDSItemDefinition >> isField [
	^ false.
]

{ #category : #accessing }
MDDSItemDefinition >> name [
	^ name
]

{ #category : #accessing }
MDDSItemDefinition >> name: aName [
	name:= aName.
]

{ #category : #converting }
MDDSItemDefinition >> rosdefinition [
	^ self subclassResponsibility .
]

{ #category : #accessing }
MDDSItemDefinition >> type [
	^ typeDefiniton typeBuilder buildTypeMarshaller.
]

{ #category : #accessing }
MDDSItemDefinition >> typeDefinition [
	^ typeDefiniton.
]

{ #category : #accessing }
MDDSItemDefinition >> typeDefinition: aType [
	self assert: (aType isKindOf: MDDSTypeBuilder) not.
	typeDefiniton := aType
]
