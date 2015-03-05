"
A MDDSHeaderEncoder is specific decoder that is used for header logic. It is not defined in the main decoder because is kind of addon, since the type system is a bit different. Then, in order to keep the rest clear all this logic is encapsulated
"
Class {
	#name : #MDDSHeaderEncoder,
	#superclass : #MDDSEncoder,
	#category : #'MetaDDS-Encoding'
}

{ #category : #'as yet unclassified' }
MDDSHeaderEncoder class >> fieldNameSeparator [
	^61 "$=  asInteger"
]

{ #category : #'as yet unclassified' }
MDDSHeaderEncoder >> encodeHeader: aHeader [
	aHeader attributes do: [ :attr | self encodeHeaderAttribute: attr ]
]

{ #category : #'as yet unclassified' }
MDDSHeaderEncoder >> encodeHeaderAttribute: aHeaderAttribute [
	| rawValue |
	rawValue := aHeaderAttribute name asByteArray , self class fieldNameSeparator asByteArray
		, aHeaderAttribute value asByteArray.
	self encodeUint32: rawValue size.
	self encodeBytes: rawValue
]
