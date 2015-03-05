"
PhaROSFieldDefinition Is an entry of a type. It has name and type.
"
Class {
	#name : #MDDSFieldDefinition,
	#superclass : #MDDSItemDefinition,
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #converting }
MDDSFieldDefinition >> getter [ 
	^ ('{1}' , String crlf, String tab, '^ self getAt: #{1}. ', String crlf) translated format: { name}
]

{ #category : #converting }
MDDSFieldDefinition >> hasToInstallHelper [
	^ typeDefiniton isCollection
]

{ #category : #converting }
MDDSFieldDefinition >> helper [
	^ ('add{1}: aValue' , String crlf, String tab, '^ self {2} add: aValue. ', String crlf ) translated format: { (name capitalized copyFrom:1 to: name size -1 ) . name } 
]

{ #category : #converting }
MDDSFieldDefinition >> initializer [
	^  (String tab, ' self {1}: {2}. ', String crlf) translated format: { name . self type defaultValueString }
]

{ #category : #testing }
MDDSFieldDefinition >> isField [
	^ true
]

{ #category : #converting }
MDDSFieldDefinition >> rosdefinition [ 
	^ ' {1} {2}' format: {  self typeDefinition typeName . name  }.
]

{ #category : #converting }
MDDSFieldDefinition >> setter [
	^ ('{1}: aValue' , String crlf, String tab, '^ self at: #{1} put: aValue. ', String crlf ) translated format: { name }
]
