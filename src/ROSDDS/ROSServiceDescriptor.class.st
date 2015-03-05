Class {
	#name : #ROSServiceDescriptor,
	#superclass : #MDDSEntity,
	#instVars : [
		'uri'
	],
	#category : #'ROSDDS-Proxy'
}

{ #category : #'as yet unclassified' }
ROSServiceDescriptor class >> domain: aDomain name: aParticipantName uri: anUri. [
	^ (super  domain: aDomain name: aParticipantName ) uri: anUri; yourself
	
]

{ #category : #registration }
ROSServiceDescriptor >> register: aRosaParticipant [ 
	aRosaParticipant registerService: self. 
]

{ #category : #'as yet unclassified' }
ROSServiceDescriptor >> uri: anUri [
	uri := anUri 
]
