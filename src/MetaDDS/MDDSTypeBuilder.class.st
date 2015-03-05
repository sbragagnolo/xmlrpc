"
PhaROSMessageTypeBuilder  named: #blaa package: #ble defined: { 
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
		ROSType definedBy: 'std_msgs/Header' named: #header.
	}.

Is in charge of generating Ros definition of a type, Pharo definition of the type, and generate the related class in pharo. 
"
Class {
	#name : #MDDSTypeBuilder,
	#superclass : #Object,
	#instVars : [
		'definition'
	],
	#category : #'MetaDDS-TypesDefinition'
}

{ #category : #'instance creation' }
MDDSTypeBuilder class >> defined: aDefinition [

	^ self new  definition: aDefinition ; 
				yourself.
]

{ #category : #'related class building' }
MDDSTypeBuilder >> buildDTOClass [
	| class |
	class := MDDSAbstractDTO
		subclass: self classname asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'MDDSGenerated'.
	self installMethodsIn: class.
	self installConstantsIn: class.
	^ class
]

{ #category : #building }
MDDSTypeBuilder >> buildTypeMarshaller [
	^ (MDDSCompositeType named: self name definedBy: definition fields withConstants: definition constants)
		relatedClass: self relatedClass;
		yourself
]

{ #category : #'related class building' }
MDDSTypeBuilder >> classname [
	^ (self name copyReplaceAll: '/' with: '_') capitalized
]

{ #category : #accessing }
MDDSTypeBuilder >> definition [
	^ definition
]

{ #category : #accessing }
MDDSTypeBuilder >> definition: anArrayOfAssociations [
	definition := anArrayOfAssociations
]

{ #category : #proto }
MDDSTypeBuilder >> forPhaROSTyping [
	^ self buildTypeMarshaller  
]

{ #category : #'related class building' }
MDDSTypeBuilder >> installConstantsIn: aClass [
	self definition constants do: [ :constant | aClass class compile: constant classAccessor ]
]

{ #category : #'related class building' }
MDDSTypeBuilder >> installMethodsIn: aClass [
	self definition fields
		do: [ :field | 
			aClass compile: field setter.
			aClass compile: field getter.
			field hasToInstallHelper
				ifTrue: [ aClass compile: field helper ] ].
	aClass
		compile:
			((self definition fields collect: #initializer)
				inject: 'initialize' , String crlf , String tab , 'super initialize.' , String crlf
				into: [ :acc :line | acc , line ])
]

{ #category : #proto }
MDDSTypeBuilder >> isServiceType [
	^ false
]

{ #category : #accessing }
MDDSTypeBuilder >> name [
	^  definition name.
]

{ #category : #building }
MDDSTypeBuilder >> relatedClass [
	^ Smalltalk at: self classname asSymbol ifAbsent: [ self buildDTOClass ]
]

{ #category : #converting }
MDDSTypeBuilder >> rosdefinition [
	^ definition rosdefinition.
]

{ #category : #accessing }
MDDSTypeBuilder >> shortName [
	^ self name
]
