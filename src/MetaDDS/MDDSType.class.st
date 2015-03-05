"
This is a type it self, it has the ability to load it definition and define marshaling/ unmarshaling objects
"
Class {
	#name : #MDDSType,
	#superclass : #MDDSEntity,
	#instVars : [
		'md5sum',
		'marshaller',
		'plainDefinition'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSType class >> domain: aDomain name: aName marshaller: aTypeMarshaller md5sum: aSum [
	^ (self domain: aDomain name: aName) marshaller: aTypeMarshaller; md5sum: aSum; yourself.
]

{ #category : #accessing }
MDDSType >> isTypePlaceHolder [
	^ false.
]

{ #category : #accessing }
MDDSType >> marshaller [
	^ marshaller
]

{ #category : #accessing }
MDDSType >> marshaller: aTypeMarshaller [
	marshaller := aTypeMarshaller
]

{ #category : #accessing }
MDDSType >> md5sum [
	^ md5sum ifNil: ''
]

{ #category : #accessing }
MDDSType >> md5sum: aSum [
	md5sum := aSum
]

{ #category : #accessing }
MDDSType >> plainDefinition [
	^ plainDefinition ifNil: [ plainDefinition := domain plainTypeDefinitionFor: self ]
]

{ #category : #accessing }
MDDSType >> verify: aTypeName md5: aMd5Sum [
	^ aTypeName isEmpty
		or: [ aMd5Sum isEmpty or: [ self name = aTypeName and: [ self md5sum isEmpty  or: [ self md5sum = aMd5Sum ] ] ] ]
]
