"
A protocol is a reification of the protocol it self. 
The protocol in a DDS, where connections are one way only is the combination of:
	 # The connection handshake.
	 # The way to encode each type.
	 # The way each type is structured.
By example, the TCPROS protocol
	# The connection hand shake defines the quality of service and is a two ways hand shake.
	# The way to encode each type is the standart one  (Defined in MDDSEncoder/MDDSDecoder)
	# The way to structure the data is the standar one (Defined in MDDSBaseTypeMarshaller hierarchy)
"
Class {
	#name : #MDDSProtocol,
	#superclass : #Object,
	#instVars : [
		'encoder',
		'decoder'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSProtocol class >> encoding: anEncoder decoding: aDecoder [ 
	^ self new encoder: anEncoder ; decoder: aDecoder ; yourself.
	
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> connect: aMDDSConnectionPetition [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> createDecoderOn: aStream with: aTypeMarshaller [
	| aDecoder |
	aDecoder := decoder on: aStream.
	self initializeDecoder: aDecoder with: aTypeMarshaller.
	^ aDecoder
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> createSocketForlistenOn: aPort [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> decoder: aDecoder [
	decoder := aDecoder
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> dump: aValue with: aTypeMarshaller [
	| stream anEncoder buffer valueSize |
	valueSize := aTypeMarshaller dataTypeSizeFor: aValue.
	buffer := ByteArray new: valueSize + 4.
	stream := WriteStream on: buffer.
	anEncoder := encoder on: stream.
	anEncoder encodeInt32: valueSize.
	aTypeMarshaller serialize: aValue into: anEncoder.
	^ buffer
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> encoder: anEncoder [
	encoder := anEncoder
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> initializeDecoder: aDecoder with: aTypeMarshaller [
	| size |
	size := aDecoder nextEncodedUint32.
	(aTypeMarshaller isAPossibleSize: size)
		ifFalse: [ MDDSError signal: ' Unexpected Value' ].
	size > 20000000
		ifTrue: [ 
			"too long, maybe is a problem in buffer. "
			aDecoder resetBuffers.
			self error: 'Warning. trying to load ' , size asString , ' bytes' ].
	^ aDecoder
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> load: aByteArray with: aTypeMarshaler [
	^ self loadStream: (ReadStream on: aByteArray) with: aTypeMarshaler
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> loadStream: aStream with: aTypeMarshaler [
	^ aTypeMarshaler decode: (self createDecoderOn: aStream with: aTypeMarshaler)
]

{ #category : #'as yet unclassified' }
MDDSProtocol >> name [
	^ self subclassResponsibility
]
