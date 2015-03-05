"
A PhaROSTypeDefinition is a reification of set of fields and constants. 
"
Class {
	#name : #MDDSTypeDefinition,
	#superclass : #Object,
	#instVars : [
		'definition',
		'name',
		'md5sum'
	],
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #'as yet unclassified' }
MDDSTypeDefinition class >> message [
	^ MDDSTypeDefinition.
]

{ #category : #'instance creation' }
MDDSTypeDefinition class >> named: aTypeName defined: anArrayOfDefinitions [
	^ self new name: aTypeName;  definition: anArrayOfDefinitions; yourself
]

{ #category : #accessing }
MDDSTypeDefinition >> at: aName [
	^ definition detect: [ :def | def name = aName ]
]

{ #category : #accessing }
MDDSTypeDefinition >> atPosition: anIndex [
	^ definition at: anIndex
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> beRegisteredBy: aTypeLoader [
	self constants do: [ : constant | constant typeDefinition beRegisteredBy: aTypeLoader  ].
	self fields do: [ :field | field typeDefinition beRegisteredBy: aTypeLoader  ].
	^ aTypeLoader privateRegisterTypeDefinition: self.
	
]

{ #category : #accessing }
MDDSTypeDefinition >> constant: aFieldName [ 
	^ self findConstant: aFieldName ifNone: [  MDDSError signal:  aFieldName, ' is not a valid field ' ].
]

{ #category : #constants }
MDDSTypeDefinition >> constants [
	^ definition select: #isConstant
]

{ #category : #accessing }
MDDSTypeDefinition >> definition: anArrayOfDefinitions [
	definition := anArrayOfDefinitions 
]

{ #category : #accessing }
MDDSTypeDefinition >> field: aFieldName [ 
	^ self findField: aFieldName ifNone: [  MDDSError signal:  aFieldName, ' is not a valid field ' ].
]

{ #category : #accessing }
MDDSTypeDefinition >> fields [
	^ definition select: #isField
]

{ #category : #find }
MDDSTypeDefinition >> findConstant: aFieldName ifNone: aBlockClosure [ 
	^ (definition select:#isConstant) detect: [ : f | f name = aFieldName  ] ifNone: aBlockClosure .
]

{ #category : #find }
MDDSTypeDefinition >> findField: aFieldName ifNone: aBlockClosure [ 
	^ (definition select:#isField) detect: [ : f | f name = aFieldName  ] ifNone: aBlockClosure .
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> md5sum [
	^ md5sum
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> md5sum:	aString [
		md5sum := aString
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> name [
	^ name
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> name: aName [
	name := aName
]

{ #category : #converting }
MDDSTypeDefinition >> rosdefinition [
	^ definition inject: '' into: [ :acc :item | acc, item rosdefinition, String lf  ].
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> typeBuilder [
	^ MDDSTypeBuilder defined: self.
]

{ #category : #'as yet unclassified' }
MDDSTypeDefinition >> typeName [
	^ name
]
