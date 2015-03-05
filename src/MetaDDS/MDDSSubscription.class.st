"
A MDDSSubscription is a conection in between topic readings and a set of callbacks. 
"
Class {
	#name : #MDDSSubscription,
	#superclass : #Object,
	#instVars : [
		'onRead',
		'onFailure',
		'onStop',
		'participant',
		'connections'
	],
	#classInstVars : [
		'defaultBlock',
		'failBlock'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #accessing }
MDDSSubscription class >> defaultBlock [
	^ defaultBlock ifNil: [ defaultBlock:=[  ]].
]

{ #category : #constructor }
MDDSSubscription class >> defaultForParticipant: aParticipant [
	^ self forParticipant: aParticipant onRead: self onRead onFailure: self onFailure onStop: self onStop.
]

{ #category : #accessing }
MDDSSubscription class >> failBlock [
	^ failBlock ifNil: [ failBlock := [: e| Transcript open; show: e messageText; cr. ]].
]

{ #category : #constructor }
MDDSSubscription class >> forParticipant: aParticipant onRead: onRead onFailure: onFailure onStop: onStop [ 
	^ self new participant: aParticipant; onRead:  onRead; onFailure: onFailure; onStop: onStop ; yourself.
]

{ #category : #'default-configuration' }
MDDSSubscription class >> onFailure [
	^ self failBlock.
]

{ #category : #'default-configuration' }
MDDSSubscription class >> onRead [
	^ self defaultBlock .
]

{ #category : #'default-configuration' }
MDDSSubscription class >> onStop [
	^ self defaultBlock .
]

{ #category : #accessing }
MDDSSubscription >> connections [
	^ connections 
	
]

{ #category : #'as yet unclassified' }
MDDSSubscription >> destroy [
	connections do: #destroy.
	connections removeAll.
	
]

{ #category : #accessing }
MDDSSubscription >> dispatch: aReceivedMessage [
	self noteNewMessage: aReceivedMessage.
]

{ #category : #accessing }
MDDSSubscription >> initialize [
	super initialize.
	connections := Set new.
]

{ #category : #accessing }
MDDSSubscription >> noteError: anError [
	onFailure cull: anError messageText.
]

{ #category : #accessing }
MDDSSubscription >> noteFailure: aFailure [
	onFailure cull: aFailure
]

{ #category : #accessing }
MDDSSubscription >> noteNewMessage: aMessage [
	onRead value: aMessage
]

{ #category : #accessing }
MDDSSubscription >> noteStop [
	onStop value.
]

{ #category : #accessing }
MDDSSubscription >> noteStop: aConnection [
	connections remove: aConnection.

]

{ #category : #accessing }
MDDSSubscription >> onFailure [
	^ onFailure
]

{ #category : #accessing }
MDDSSubscription >> onFailure: aBlockClosure [ 
	onFailure := aBlockClosure 
]

{ #category : #accessing }
MDDSSubscription >> onRead [
	^ onRead
]

{ #category : #accessing }
MDDSSubscription >> onRead: aBlockClosure [ 
	onRead := aBlockClosure
]

{ #category : #accessing }
MDDSSubscription >> onStop [
	^ onStop
]

{ #category : #accessing }
MDDSSubscription >> onStop: aBlockClosure [ 
	onStop := aBlockClosure 
]

{ #category : #accessing }
MDDSSubscription >> participant [
	^ participant.
]

{ #category : #accessing }
MDDSSubscription >> participant: aParticipant [
	participant := aParticipant
]

{ #category : #accessing }
MDDSSubscription >> registerConnection: aConnection [
	" Now i should make a difference between subscriptions in terms of participant and where the connection is coming from. "

	connections add: aConnection.
	aConnection messageDispatcher: self.
	aConnection noteIsRegistered.
]
