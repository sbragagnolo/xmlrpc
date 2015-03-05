"
A PhaROSArrayType is an array of variable length and fixed type.
"
Class {
	#name : #MDDSArrayType,
	#superclass : #MDDSCollectionType,
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'pseudo-dsl' }
MDDSArrayType class >> named: aName [
	self error: 'Array need more than just name. Use #named:ofType: instead'
]

{ #category : #construction }
MDDSArrayType class >> of: aClass [
	^ self new ofClass: aClass; yourself .
]

{ #category : #'pseudo-dsl' }
MDDSArrayType class >> registerAlterName [
	" Name collision. DSL constructor name is at Array class as extention method "
]

{ #category : #accessing }
MDDSArrayType >> dataTypeSize [
	^(1024*1024*10).
"
	self error: 'You need to specify the related value to this kind of array'."
]

{ #category : #accessing }
MDDSArrayType >> dataTypeSizeFor: aValue [
	^ (super dataTypeSizeFor: aValue )+ 4.
]

{ #category : #accessing }
MDDSArrayType >> defaultValueString [ 
	^ 'OrderedCollection new '.
	
]

{ #category : #initialize }
MDDSArrayType >> newInstance [ 
	^ {}.
]

{ #category : #initialize }
MDDSArrayType >> serialize:aValue into: anEncoder [
	^ anEncoder encodeArray: aValue of: self relatedType.

]

{ #category : #accessing }
MDDSArrayType >> sizeFor: aDecoder [ 
	^ aDecoder nextEncodedUint32.
]

{ #category : #initialize }
MDDSArrayType >> typeName [
	^ (relatedType ifNil: [ '?' ] ifNotNil: [ :t | t typeName ]) , '[]'
]
