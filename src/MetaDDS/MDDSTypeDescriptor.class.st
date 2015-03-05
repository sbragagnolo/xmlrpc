"
A publisher  subscriber protocol is based on the sharing and publication of types. This type represent the type idea, but not it definition or it marshaller. 


"
Class {
	#name : #MDDSTypeDescriptor,
	#superclass : #MDDSEntity,
	#instVars : [
		'definition'
	],
	#category : #'MetaDDS-Reflection'
}

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor class >> isUnknown: aTypeDescriptor [
	^ self unknownWildcard = aTypeDescriptor name
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor class >> unknownTypeFor: aDomain [
	^ super domain: aDomain name: self unknownWildcard.
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor class >> unknownWildcard [
	^ #*
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor >> createType [
	^ (self isUnknown or: [ self isUndefined ])
		ifTrue: [ domain createTypePlaceHolder: name asString ]
		ifFalse: [ domain createTypeNamed: name asString definedBy: self definition ]
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor >> definition [
	^ definition ifNil: [ definition := domain typeDefinition: name ]
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor >> describes: aType [
	^ name = aType name.
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor >> domain: aDomain [	
	super domain: aDomain.
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor >> isUndefined [
	^  (domain isTypeDefined: name) not 
]

{ #category : #'as yet unclassified' }
MDDSTypeDescriptor >> isUnknown [
	^ self class isUnknown: self
]
