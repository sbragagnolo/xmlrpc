"
A PhaROSCollectionType is an abstract representation of collections type
"
Class {
	#name : #MDDSCollectionType,
	#superclass : #MDDSBaseTypeMarshaller,
	#instVars : [
		'relatedClass',
		'relatedType'
	],
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSCollectionType class >> registerAlterName [
	" This is an abstract class. Does not apply "
	self = MDDSCollectionType ifFalse: [ 
		super registerAlterName.
	 ]
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> dataTypeSizeFor: aValue [
self flag: #cambiarEstooo. " "

	(self isAPossibleValue: aValue ) ifFalse: [
		MDDSError signal: 'Unexpected value'.
	].
	
	^(aValue inject: 0 into:[
		:acc :val | 
		acc + (self  relatedType dataTypeSizeFor: val ).
	]).
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> decode: aDecoder [ 
	^ (1 to: (self sizeFor: aDecoder ) ) collect: [
		:i |
		self relatedType decode: aDecoder.
	] .
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> isAPossibleSize: aSize [
	^ aSize > 0.
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> isAPossibleValue: aValue [
	^( aValue isKindOf: Collection ) and: [
		aValue allSatisfy: [
			:val |
			self relatedType isAPossibleValue: val.
		]	
	].
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> isCollectionType [
	^ true
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> ofClass: aRosTypeClass [
	relatedClass := aRosTypeClass.
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> ofType: aRosType [
	relatedType  := aRosType.
	relatedClass := aRosType class.
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> relatedType [
	^ relatedType ifNil: [ relatedType := relatedClass new ].
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> relatedType: aType [
	relatedType := aType.
	relatedClass := aType class.
	
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> setEncodeDecodeSelectors [
	" Refactor needed here ."
	encodeSelector := #doesNotApplyHere.
	decodeSelector := #doesNotApplyHere.
]

{ #category : #'as yet unclassified' }
MDDSCollectionType >> sizeFor: aDecoder [ 
	^ self subclassResponsibility.
]
