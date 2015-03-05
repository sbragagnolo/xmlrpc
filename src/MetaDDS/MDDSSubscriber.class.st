"
Represents the subscription to a topic. 
There is just one subscriber per topic, It handles allt the needed subscriptions.

subscriber := topic subscriber.
subscription := subscriber onRead: [ : val |  ] onFailure: [ :fail | ] onStop:["""" ].

subcription := subcriber subscribe.

subscription := topic onRead: [ : val |  ]; onFailure: [ :fail | ]; onStop:["""" ].


subscription cancel.
				
			
topic
"
Class {
	#name : #MDDSSubscriber,
	#superclass : #MDDSTopicInteractor,
	#instVars : [
		'subscriptions'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #subscription }
MDDSSubscriber >> forParticipant: aParticipant [
	^ self
		registerIfNeeded: aParticipant
		creatingSubscriptionWith: [ 
			(domain createSubscriptionFor: aParticipant)
				onRead: [ :m |  ];
				yourself ]
]

{ #category : #subscription }
MDDSSubscriber >> forParticipant: aParticipant onRead: onRead [
	^ self
		registerIfNeeded: aParticipant
		creatingSubscriptionWith: [ 
			(domain createSubscriptionFor: aParticipant)
				onRead: onRead;
				yourself ]
]

{ #category : #creation }
MDDSSubscriber >> forParticipant: aParticipant onRead: onRead onFailure: onFailure [
	^ self
		registerIfNeeded: aParticipant
		creatingSubscriptionWith: [ 
			(domain createSubscriptionFor: aParticipant)
				onRead: onRead;
				onFailure: onFailure;
				yourself ]
]

{ #category : #subscription }
MDDSSubscriber >> forParticipant: aParticipant onRead: onRead onFailure: onFailure onStop: onStop [
	^ self
		registerIfNeeded: aParticipant
		creatingSubscriptionWith: [ 
			(domain createSubscriptionFor: aParticipant)
				onRead: onRead;
				onFailure: onFailure;
				onStop: onStop;
				yourself ]
]

{ #category : #initialization }
MDDSSubscriber >> initialize [
	super initialize.
	subscriptions := Set new.
]

{ #category : #'as yet unclassified' }
MDDSSubscriber >> isRegistered [
	^ subscriptions isEmpty not.
]

{ #category : #registry }
MDDSSubscriber >> register: aSubscription [
	subscriptions add: aSubscription.
	domain note: (MDDSTopicAnnouncement participant: aSubscription participant isNowSubscribedTo: self with: aSubscription ).
	^ aSubscription
]

{ #category : #private }
MDDSSubscriber >> registerIfNeeded: aParticipant creatingSubscriptionWith: aBlock [
	^ self subscriptionFor: aParticipant ifNone: [ self register: aBlock value ]
]

{ #category : #'as yet unclassified' }
MDDSSubscriber >> subscribe: aParticipant [
	^ self registerIfNeeded: aParticipant creatingSubscriptionWith: [ domain createSubscriptionFor: aParticipant ]
]

{ #category : #'as yet unclassified' }
MDDSSubscriber >> subscriptionFor: aParticipant [ 
	^ self subscriptionFor: aParticipant ifNone: [ self error: 'There is not subscription for the given participant' ]. 
]

{ #category : #'as yet unclassified' }
MDDSSubscriber >> subscriptionFor: aParticipant ifNone: aBlock [ 
	^ subscriptions detect: [ :each | each participant = aParticipant ] ifNone: aBlock 
]

{ #category : #accessing }
MDDSSubscriber >> subscriptions [
	^ subscriptions
]

{ #category : #registry }
MDDSSubscriber >> unregister: aSubscription [
	| announcement |
	subscriptions remove: aSubscription.
	announcement := MDDSTopicAnnouncement
		participant: aSubscription participant
		isNotSubscribedAnymoreTo: self
		with: aSubscription.
	domain note: announcement.
	aSubscription destroy.

]

{ #category : #registry }
MDDSSubscriber >> unregisterAll [
	subscriptions do: [ :s | self unregister: s ].
]

{ #category : #'as yet unclassified' }
MDDSSubscriber >> unsubscribe: aParticipant [
	^ self unregister: (self subscriptionFor: aParticipant ifNone: [ self error: ' There is not any subscription for the given Participant '])
]
