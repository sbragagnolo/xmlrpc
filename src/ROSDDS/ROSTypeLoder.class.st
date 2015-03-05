"
The type loader is an abstract class that defines a basic cache and abstract methods.
It can be subclassed for usign command oriented loading (rosmsg) and  other kind of strategies it is not prepared to be mixed ( since there is una cahce per loader )
"
Class {
	#name : #ROSTypeLoder,
	#superclass : #MDDSTypeLoader,
	#instVars : [
		'builtinTypes'
	],
	#category : #'ROSDDS-Typeloader'
}

{ #category : #constructor }
ROSTypeLoder class >> commandBased [
	^ ROSCommandTypeLoader new.
]

{ #category : #initialization }
ROSTypeLoder >> initialize [

	super initialize.
	builtinTypes := Dictionary new.
	
	builtinTypes at: 'byte' put: (MDDSBasicTypeDefinition for:  MDDSInt8Type new).
	builtinTypes at: 'char' put: (MDDSBasicTypeDefinition for:  MDDSInt8Type new).
	builtinTypes at: 'bool' put: (MDDSBasicTypeDefinition for:  MDDSBoolType new).
	builtinTypes at: 'float32' put: (MDDSBasicTypeDefinition for:  MDDSFloat32Type new).
	builtinTypes at: 'float64' put: (MDDSBasicTypeDefinition for:  MDDSFloat64Type new).
	
	builtinTypes at: 'int8' put: (MDDSBasicTypeDefinition for:  MDDSInt8Type new).
	builtinTypes at: 'int16' put: (MDDSBasicTypeDefinition for:  MDDSInt16Type new).
	builtinTypes at: 'int32' put: (MDDSBasicTypeDefinition for:  MDDSInt32Type new).
	builtinTypes at: 'int64' put: (MDDSBasicTypeDefinition for:  MDDSInt64Type new).
	
	builtinTypes at: 'uint8' put: (MDDSBasicTypeDefinition for:  MDDSUInt8Type new).
	builtinTypes at: 'uint16' put: (MDDSBasicTypeDefinition for:  MDDSUInt16Type new).
	builtinTypes at: 'uint32' put: (MDDSBasicTypeDefinition for:  MDDSUInt32Type new).
	builtinTypes at: 'uint64' put: (MDDSBasicTypeDefinition for:  MDDSUInt64Type new).
	
	builtinTypes at: 'time' put: (MDDSBasicTypeDefinition for:  MDDSTimeType new).
	builtinTypes at: 'duration' put: (MDDSBasicTypeDefinition for:  MDDSDurationType new).
	builtinTypes at: 'string' put: (MDDSBasicTypeDefinition for:  MDDSStringType new).
]

{ #category : #initialization }
ROSTypeLoder >> loadTypeDefinition: aTypeId ifAbsent: aBlock [
	self subclassResponsibility
]

{ #category : #initialization }
ROSTypeLoder >> typeDefinition: aTypeId ifAbsent: aBlock [
	^ builtinTypes
		at: aTypeId
		ifAbsent: [ 
			| type |
			type := super typeDefinition: aTypeId ifAbsent:[  #loading ].
			type == #loading
				ifTrue: [ registry at: aTypeId put: (self loadTypeDefinition: aTypeId ifAbsent: aBlock) ]
				ifFalse: [ type ] ]
]
