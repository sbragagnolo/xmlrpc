"
A PhaROSConstantDefinition  Is an constant usable in the type that is part of. It has name, type and value.
"
Class {
	#name : #MDDSConstantDefinition,
	#superclass : #MDDSItemDefinition,
	#instVars : [
		'value'
	],
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #'instance creation' }
MDDSConstantDefinition class >> name: aName typedAs: aTypeDefinition withValue: aValue [ 
	^ self new name: aName; type: aTypeDefinition; value: aValue; yourself
]

{ #category : #converting }
MDDSConstantDefinition >> classAccessor [
	^ ('{1}' , String crlf , String tab , '^{2}' , String crlf) translated
		format:
			{(name asLowercase).
			(self valueForGeneration)}
]

{ #category : #testing }
MDDSConstantDefinition >> isConstant [ 	
	^ true
]

{ #category : #accessing }
MDDSConstantDefinition >> name: aName [
	name:= aName
]

{ #category : #converting }
MDDSConstantDefinition >> rosdefinition [ 
	^ ' {1} {2}={3}' format: { self typeDefinition typeName . name . self valueForGeneration }.
]

{ #category : #accessing }
MDDSConstantDefinition >> value: aValue [
	value:= aValue.
]

{ #category : #converting }
MDDSConstantDefinition >> valueForGeneration [
	^ ((self typeDefinition isKindOf: MDDSBasicTypeDefinition)
		and: [ self typeDefinition typeSerializer isKindOf: MDDSStringType ])
		ifTrue: [ '''{1}''' format: {(value asString)} ]
		ifFalse: [ value asString ]
]
