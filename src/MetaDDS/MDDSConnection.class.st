"
A MDDSConnection is the reification of a connection in between publisher and subscriber
"
Class {
	#name : #MDDSConnection,
	#superclass : #Object,
	#instVars : [
		'protocol'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #accessing }
MDDSConnection >> destroy [
]

{ #category : #'as yet unclassified' }
MDDSConnection >> id [
 	^ self hash asString
]

{ #category : #'as yet unclassified' }
MDDSConnection >> isConnected [
	^ socket isConnected
]

{ #category : #'as yet unclassified' }
MDDSConnection >> isReader [
	^ false
]

{ #category : #accessing }
MDDSConnection >> noteIsRegistered [
]

{ #category : #accessing }
MDDSConnection >> protocol [
	^ protocol
]

{ #category : #accessing }
MDDSConnection >> protocol: anObject [
	protocol := anObject
]
