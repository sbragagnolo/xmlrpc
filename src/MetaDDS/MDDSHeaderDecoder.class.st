"
A MDDSHeaderDecoder is specific decoder that is used for header logic. It is not defined in the main decoder because is kind of addon, since the type system is a bit different. Then, in order to keep the rest clear all this logic is encapsulated
"
Class {
	#name : #MDDSHeaderDecoder,
	#superclass : #MDDSDecoder,
	#category : #'MetaDDS-Encoding'
}

{ #category : #'as yet unclassified' }
MDDSHeaderDecoder class >> fieldNameSeparator [
	^61 "$=  asInteger"
]

{ #category : #'as yet unclassified' }
MDDSHeaderDecoder >> nextEncodedAttribute [
	| fieldsize buffer name rawValue |
	fieldsize := self nextEncodedUint32.
	buffer := ReadStream on: (stream next: fieldsize).
	name := buffer upTo: self class fieldNameSeparator.
	rawValue := buffer upToEnd.
	^ MDDSHeaderAtribute name: name asString value: rawValue asString
]

{ #category : #'as yet unclassified' }
MDDSHeaderDecoder >> nextEncodedHeader [
	| headerSize backupStream header |
	headerSize := self nextEncodedUint32.
	backupStream := stream.
	header := MDDSHandshakeHeader new.
	[ 
	stream := ReadStream on: (backupStream next: headerSize).
	[ stream atEnd ] whileFalse: [ header attributes add: self nextEncodedAttribute ] ]
		ensure: [ stream := backupStream ].
	^ header
]
