"
Reading connection is a reification of the socket, with protocol and marshalling in terms of consuming 
"
Class {
	#name : #MDDSReadingNetworkConnection,
	#superclass : #MDDSReadingConnection,
	#instVars : [
		'keepRunning',
		'process',
		'stream',
		'urlrpc',
		'socket'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSReadingNetworkConnection class >> protocol: aProtocol socket: aSocket stream: aStream [
	^ self new protocol: aProtocol ; socket: aSocket ; stream: aStream;  yourself
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> destroy [
	self stop.
	messageDispatcher := nil.
	socket close.
	socket := nil.
	stream close.
	stream := nil.
	protocol := nil.
	process := nil. 
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> initialize [
	keepRunning := false.
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> noteIsRegistered [
	super noteIsRegistered.
	self start.
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> socket [
	^ socket
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> socket: anObject [
	socket := anObject
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> start [
	keepRunning
		ifFalse: [ 
			keepRunning := true.
			process := [ 
			| value |
			[ keepRunning ]
				whileTrue: [ 
					[ 
					value := protocol loadStream: stream with: typeMarshaller.
					messageDispatcher dispatch: value ]
						on: Error
						do: [ :err | 
							messageDispatcher noteError: err.
							keepRunning := socket isConnected ] ].
			messageDispatcher noteStop: self.
			self destroy ] shootIt asStickyReference ]
		ifTrue: [ self error: 'The related process is already running!' ]
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> stop [
	keepRunning
		ifTrue: [ 
			keepRunning := false.
			process := nil ]
		ifFalse: [ self error: 'The related process is notrunning!' ]
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> stream: aStream [
	stream := aStream.
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> urlrpc [
	^ urlrpc
]

{ #category : #accessing }
MDDSReadingNetworkConnection >> urlrpc: anUrl [
	urlrpc := anUrl.
]
