"
Unit test framework.
"
Class {
	#name : #SpyTest,
	#superclass : #TestCase,
	#category : #'Spy-Tests'
}

{ #category : #debugging }
SpyTest >> assertEquals: ob to: other msg: msg [ 
	"Make sure the two objects are equal."
	ob = other
		ifFalse: [self signalFailure: msg , ' (expected ' , ob asString , ', got ' , other asString , ')']
]

{ #category : #debugging }
SpyTest >> assertNil: ob withMessage: msg [ 
	"Verify the provided object is nil."
	ob
		ifNotNil: [self signalFailure: msg , ' (expected nil, wasn''t)']
]

{ #category : #debugging }
SpyTest >> assertNotNil: ob withMessage: msg [ 
	"Verify the provided objects is not nil."
	ob
		ifNil: [self signalFailure: msg , ' (expected not nil, was)']
]

{ #category : #debugging }
SpyTest >> assertSame: ob to: otherOb withMessage: msg [ 
	"Verify the two objects represent the same instance."
	ob == otherOb
		ifFalse: [self signalFailure: msg , ' (expected ' , ob asString , ', got ' , otherOb asString , ')']
]
