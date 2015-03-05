"
This builder is a polimorfic object that allow us to have a builder that do not build, for the basic types, as Uint, etc.
"
Class {
	#name : #MDDSBasicTypeDefinition,
	#superclass : #Object,
	#instVars : [
		'typeSerializer'
	],
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #'instance creation' }
MDDSBasicTypeDefinition class >> for: aType [
	^ self new typeSerializer: aType; yourself.
]

{ #category : #accessing }
MDDSBasicTypeDefinition >> beRegisteredBy: aTypeLoader [
	^ self
]

{ #category : #building }
MDDSBasicTypeDefinition >> buildTypeMarshaller [
	^ typeSerializer.
]

{ #category : #building }
MDDSBasicTypeDefinition >> typeBuilder [
	^ self.
]

{ #category : #accessing }
MDDSBasicTypeDefinition >> typeName [
	^ typeSerializer typeName.
]

{ #category : #'as yet unclassified' }
MDDSBasicTypeDefinition >> typeSerializer [
	^ typeSerializer
]

{ #category : #accessing }
MDDSBasicTypeDefinition >> typeSerializer: aTypeSerializer [ 
	typeSerializer := aTypeSerializer.
]
