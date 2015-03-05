"
A PhaROSStringType is a variable length string type
"
Class {
	#name : #MDDSStringType,
	#superclass : #MDDSBaseTypeMarshaller,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSStringType class >> registerAlterName [
	" Name collision. DSL constructor name is at String class as extention method "
]

{ #category : #testing }
MDDSStringType >> constantValue: aValue [ 
	| realValue | 

	realValue := aValue copyReplaceAll: $' asString with:($' asString, $' asString).
	
	^  $' asString , realValue, $' asString.
	
]

{ #category : #'initialize-release' }
MDDSStringType >> dataTypeSize [
	^ 2048.
]

{ #category : #'initialize-release' }
MDDSStringType >> dataTypeSizeFor: aValue [
	(self isAPossibleValue: aValue ) ifFalse: [
		PhaROSUnexpextedValue signal: 'Unexpected value'.
	].
	^ aValue size + 4.
]

{ #category : #'as yet unclassified' }
MDDSStringType >> defaultValueString [ 
	^ $' asString, $' asString. 
]

{ #category : #'initialize-release' }
MDDSStringType >> isAPossibleSize: aSize [
	^ aSize > 0.
]

{ #category : #testing }
MDDSStringType >> isAPossibleValue: aByteString [ 
	^ aByteString isKindOf: ByteString.
]

{ #category : #'as yet unclassified' }
MDDSStringType >> newInstance [ 
	^ ''. 
]

{ #category : #'initialize-release' }
MDDSStringType >> setEncodeDecodeSelectors [
	encodeSelector := #encodeString:.
	decodeSelector := #nextEncodedString.
]

{ #category : #'initialize-release' }
MDDSStringType >> typeName [ 
	^ 'string'
]
