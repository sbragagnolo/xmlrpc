"
A PhaROSTimeType is a time stamp type.
"
Class {
	#name : #MDDSTimeType,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #accessing }
MDDSTimeType class >> dataTypeSize [
	^ 8
]

{ #category : #'pseudo-dsl' }
MDDSTimeType class >> registerAlterName [
	" Name collision. DSL constructor name is at Time class as extention method "
]

{ #category : #'as yet unclassified' }
MDDSTimeType >> defaultValueString [
	^ ' MDDSTimestamp now'. 
]

{ #category : #'as yet unclassified' }
MDDSTimeType >> isAPossibleValue: aTime [ 
	^ (aTime isKindOf: MDDSTimestamp) and: [
		aTime seconds  < 4294967296 and: [
			aTime nanoSeconds  < 4294967296 
		]
	].
]

{ #category : #'as yet unclassified' }
MDDSTimeType >> newInstance [ 
	^ Time new. 
]

{ #category : #'as yet unclassified' }
MDDSTimeType >> setEncodeDecodeSelectors [
	encodeSelector := #encodeTime:.
	decodeSelector := #nextEncodedTime.
]

{ #category : #'as yet unclassified' }
MDDSTimeType >> typeName [ 
	^ 'time'
]
