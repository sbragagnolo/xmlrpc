"
part of the dds architecutre includes a petition for connection, and, as well, support to several kind of IP based protocols
"
Class {
	#name : #MDDSConnectionPetition,
	#superclass : #MDDSConnectionDescription,
	#instVars : [
		'protocolName',
		'ip',
		'port'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSConnectionPetition class >> protocolName: aName ip: anIp port: aPort subscriber: aSubscriber participant: aParticipantMirror [ 
	^ self new protocolName: aName; ip: anIp; port: aPort; topicInteractor: aSubscriber; participant: aParticipantMirror ;yourself 
]

{ #category : #'as yet unclassified' }
MDDSConnectionPetition >> ip [
	^ ip
]

{ #category : #'as yet unclassified' }
MDDSConnectionPetition >> ip: anIPOrHostName [
	ip := anIPOrHostName 
]

{ #category : #'as yet unclassified' }
MDDSConnectionPetition >> itIsSupportedBy: aProtocol [
	^ aProtocol name = protocolName
]

{ #category : #'as yet unclassified' }
MDDSConnectionPetition >> port [
	^ port
]

{ #category : #'as yet unclassified' }
MDDSConnectionPetition >> port: aPort [
	port := aPort.
]

{ #category : #'as yet unclassified' }
MDDSConnectionPetition >> protocolName: aName [
	protocolName := aName.
	
]
