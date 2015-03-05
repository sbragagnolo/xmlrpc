"
A MDDSDomainParticipant is an entity that participates in the DDS as writer or reader
"
Class {
	#name : #MDDSDomainParticipant,
	#superclass : #MDDSEntity,
	#instVars : [
		'ip'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSDomainParticipant class >> domain: aDomain name: aName ip: anIp [
	^ (super domain: aDomain name: aName) ip: (NetNameResolver addressFromString: anIp); yourself.
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipant >> ip [
	^ ip
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipant >> ip: anIp [
	ip := anIp.
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipant >> obtainPortFor: aProtocol [
	^ domain obtainPort.
]

{ #category : #'as yet unclassified' }
MDDSDomainParticipant >> protocols [
	^ domain protocols
]
