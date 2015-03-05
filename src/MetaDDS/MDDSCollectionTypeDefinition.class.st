Class {
	#name : #MDDSCollectionTypeDefinition,
	#superclass : #MDDSBasicTypeDefinition,
	#instVars : [
		'innerTypeDefinition'
	],
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #'as yet unclassified' }
MDDSCollectionTypeDefinition class >> for: aType [
	self error: 'Collection based type definition needs a collection type and an inner type: Use for:storing: instead'
]

{ #category : #'as yet unclassified' }
MDDSCollectionTypeDefinition class >> for: aCollectionType storing: anInnerTypeDefinition [
	^ (super for: aCollectionType) innerTypeDefinition: anInnerTypeDefinition; yourself
]

{ #category : #'as yet unclassified' }
MDDSCollectionTypeDefinition >> beRegisteredBy: aTypeLoader [
	innerTypeDefinition beRegisteredBy: aTypeLoader.
	^ self.
]

{ #category : #'as yet unclassified' }
MDDSCollectionTypeDefinition >> buildTypeMarshaller [
	^ typeSerializer relatedType: (innerTypeDefinition typeBuilder buildTypeMarshaller)
]

{ #category : #'as yet unclassified' }
MDDSCollectionTypeDefinition >> innerTypeDefinition: anInnerTypeDefinition [
	innerTypeDefinition := anInnerTypeDefinition
]
