"
A MDDSParticipantDescriptor is an object that tracks events and data and describe an existant participant. The related participant is a proxy to the real participant. 
"
Class {
	#name : #MDDSParticipantDescriptor,
	#superclass : #MDDSEntity,
	#instVars : [
		'uri',
		'participant'
	],
	#category : #'MetaDDS-Reflection'
}

{ #category : #'as yet unclassified' }
MDDSParticipantDescriptor class >> domain: aDomain name: aParticipantName uri: anUri. [
	^ (super  domain: aDomain name: aParticipantName ) uri: anUri; yourself
]

{ #category : #accessing }
MDDSParticipantDescriptor >> participant [
	^ participant ifNil: [  participant := domain createParticipantFor: self ] .
]

{ #category : #accessing }
MDDSParticipantDescriptor >> uri [
	^ uri
]

{ #category : #accessing }
MDDSParticipantDescriptor >> uri: anObject [
	uri := anObject
]
