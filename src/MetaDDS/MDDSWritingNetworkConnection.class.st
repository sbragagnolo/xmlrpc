"
a writing connection puts together socket protocol and eventually, marshaller (since the marshaller is the same for each topic actor, is not accessed here, but received just in time) 


"
Class {
	#name : #MDDSWritingNetworkConnection,
	#superclass : #MDDSWritingConnection,
	#instVars : [
		'socket'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSWritingNetworkConnection class >> with: aProtocol for: aSocket [
	^ self new protocol: aProtocol ; socket: aSocket; yourself
]

{ #category : #'as yet unclassified' }
MDDSWritingNetworkConnection >> destroy [
	socket close.
]

{ #category : #testing }
MDDSWritingNetworkConnection >> isDead [
	^ socket isNil or: [ socket isConnected not ]
]

{ #category : #'as yet unclassified' }
MDDSWritingNetworkConnection >> socket [
	^ socket
]

{ #category : #'as yet unclassified' }
MDDSWritingNetworkConnection >> socket: anObject [
	socket := anObject
]

{ #category : #'as yet unclassified' }
MDDSWritingNetworkConnection >> write: aDataValue with: aMarshaller [
	" there are several scenarios where the data is not much per cycle and is sent several times per second. For this cases (sensors) having a batched writing may  be a great enhancement "

	self flag: #performance.
	socket sendData: (protocol dump: aDataValue with: aMarshaller)
]
