"
Some times the topic has not a type because the user  do not know it. In this cases, the topic will be configured with a TypePlaceHolder. This is a place holder for the type.  And during the first connection the topic should be informed and inform to the type holder in order to become it a real type. 
"
Class {
	#name : #MDDSTypePlaceHolder,
	#superclass : #MDDSEntity,
	#instVars : [
		'md5sum'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSTypePlaceHolder >> isTypePlaceHolder [
	^ true 
]

{ #category : #'as yet unclassified' }
MDDSTypePlaceHolder >> isUndefined [
	^ (name = MDDSTypeDescriptor unknownWildcard) not
]

{ #category : #'as yet unclassified' }
MDDSTypePlaceHolder >> md5sum [
	^ md5sum ifNil: ''
]

{ #category : #'as yet unclassified' }
MDDSTypePlaceHolder >> plainDefinition [
	^ ''
]

{ #category : #'as yet unclassified' }
MDDSTypePlaceHolder >> resolveRealTypeFrom: aHeader [
	^ domain
		createTypeNamed: name
		definedBy: (domain loadTypeDefinitionNamed: name definedFromString: aHeader message_definition)
]

{ #category : #'as yet unclassified' }
MDDSTypePlaceHolder >> verify: aTypeName md5: aMd5Sum [
	(self isUndefined and: [ name = aTypeName ])
		ifTrue: [ self assert: name = aTypeName ]
		ifFalse: [ name := aTypeName ].
	md5sum := aMd5Sum.
	^ true
]
