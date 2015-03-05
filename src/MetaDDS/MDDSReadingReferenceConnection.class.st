"
A MDDSReadingReferenceConnection

is the reification of the reading connection but based on a reference. Is for local participants
"
Class {
	#name : #MDDSReadingReferenceConnection,
	#superclass : #MDDSReadingConnection,
	#instVars : [
		'participant'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSReadingReferenceConnection class >> dispatchingTo: aMessageDispatcher [
	^ self new messageDispatcher: aMessageDispatcher; yourself.
]

{ #category : #'as yet unclassified' }
MDDSReadingReferenceConnection >> dispatch: aMessage [
	messageDispatcher dispatch: aMessage.
]

{ #category : #'as yet unclassified' }
MDDSReadingReferenceConnection >> participant [
	^ participant
]

{ #category : #'as yet unclassified' }
MDDSReadingReferenceConnection >> participant: aParticipant [
	participant := aParticipant
]
