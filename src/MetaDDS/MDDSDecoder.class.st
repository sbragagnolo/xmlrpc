"
A PhaROSDecoder is stream encoder. It reads from a given stream. It expose several methods per type. 
"
Class {
	#name : #MDDSDecoder,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'MetaDDS-Encoding'
}

{ #category : #'as yet unclassified' }
MDDSDecoder class >> on: aReadStream [
	^self new stream: aReadStream; yourself.
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> hasLeft: anAmountOfBytes [
	 self flag: #comment.
	
	^ true.
	
	"
		since SocketStream doesnot understand position, this maybe has not sense. 
		^stream position + anAmountOfBytes <= stream size.
	"
]

{ #category : #accessing }
MDDSDecoder >> minimumPrecision [
	^ 0.002
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedByte [
	self verifyDataAvailability.
	^ stream next
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedDuration [
	| duration |
	self verifyDataAvailability: 4 * 2.
	duration := Duration new.
	duration seconds: self nextEncodedUint32 nanoSeconds: self nextEncodedUint32.
	^ duration
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedFloat32 [
	self verifyDataAvailability: 4.
	^ (Float fromIEEE32BitByteArray: (stream next: 4)) roundUpTo: self minimumPrecision
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedFloat64 [
	self verifyDataAvailability: 8.
	^ (stream next: 8) doubleAt: 1 bigEndian: false
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedInt16 [
	| n firstDigit barray |
	self verifyDataAvailability: 2.
	barray := ReadStream on: (stream next: 2) reversed.
	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	firstDigit >= 128
		ifTrue: [ n := -16r10000 + n ].	"decode negative 16-bit integer"
	^ n
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedInt32 [
	| n firstDigit barray |
	self verifyDataAvailability: 4.
	barray := ReadStream on: (stream next: 4) reversed.
	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	firstDigit >= 128
		ifTrue: [ n := -16r100000000 + n ].	"decode negative 32-bit integer"
	^ n
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedInt64 [
	| n firstDigit barray |
	self verifyDataAvailability: 8.
	barray := stream next: 8.
	barray size = 8
		ifFalse: [ Error signal: ' there are less than 8 bytes in the stream ' ].
	barray := ReadStream on: barray reversed.
	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	firstDigit >= 128
		ifTrue: [ n := -16r10000000000000000 + n ].	"decode negative 64-bit integer"
	^ n
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedInt8 [
	| digit |
	self verifyDataAvailability.
	digit := stream next.
	^ digit < 128
		ifTrue: [ digit ]
		ifFalse: [ -16r100 + digit ]
]

{ #category : #serialize }
MDDSDecoder >> nextEncodedString [
	| length aByteArray |
	[ length := self nextEncodedUint32 ]
		on: Error
		do: [ Error signal: 'Unable to load string size' ].
	self verifyDataAvailability: length.
	aByteArray := ByteArray new: length.
	stream nextInto: aByteArray.
	^ aByteArray asString
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedTime [
	self verifyDataAvailability: 4 * 2.
	^ MDDSTimestamp fromUnixTime: self nextEncodedUint32 nanoSeconds: self nextEncodedUint32
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedUint16 [
	| n barray |
	self verifyDataAvailability: 2.
	barray := ReadStream on: (stream next: 2) reversed.
	n := barray next.
	n := (n bitShift: 8) + barray next.
	^ n
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedUint32 [
	| n  firstDigit src barray |
	self verifyDataAvailability: 4.
	src := stream next: 4.
	barray := ReadStream on: src reversed.
	[ 
	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next ]
		on: Error
		do: [ MDDSError signal: 'Unable to load 32bits UInt' ].
	^ n
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedUint64 [
	| n firstDigit barray |
	self verifyDataAvailability: 8.
	barray := ReadStream on: (stream next: 8) reversed.
	n := firstDigit := barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	n := (n bitShift: 8) + barray next.
	^ n
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> nextEncodedUint8 [
	self verifyDataAvailability.
	^ stream next
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> resetBuffers [
	stream resetBuffers.
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> stream: aStream [
	stream := aStream.
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> verifyDataAvailability [
	^ self verifyDataAvailability: 1.
]

{ #category : #'as yet unclassified' }
MDDSDecoder >> verifyDataAvailability: anAmount [
	(self hasLeft: anAmount)
		ifFalse: [ self error: 'There are no more data' ]
]
