"
A PhaROSDurationType is type that represents interval  of time
"
Class {
	#name : #MDDSDurationType,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #accessing }
MDDSDurationType class >> dataTypeSize [
	^ 8
]

{ #category : #'pseudo-dsl' }
MDDSDurationType class >> registerAlterName [
	" Name collision. DSL constructor name is at Duration class as extention method "
]

{ #category : #'as yet unclassified' }
MDDSDurationType >> defaultValueString [
	^ ' Duration seconds: 0'. 
]

{ #category : #'as yet unclassified' }
MDDSDurationType >> isAPossibleValue: aDuration [
	^ (aDuration isKindOf: Duration) and: [
		aDuration secondsField  < 4294967296 and: [
			aDuration nanoSecondsField  < 4294967296 
		]
	].
]

{ #category : #'as yet unclassified' }
MDDSDurationType >> newInstance [ 
	^ Duration new. 
]

{ #category : #'as yet unclassified' }
MDDSDurationType >> setEncodeDecodeSelectors [
	encodeSelector := #encodeDuration:.
	decodeSelector := #nextEncodedDuration.
]

{ #category : #'as yet unclassified' }
MDDSDurationType >> typeName [ 
	^ 'duration'
]
