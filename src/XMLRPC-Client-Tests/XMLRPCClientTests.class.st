"
Unit test framework.
"
Class {
	#name : #XMLRPCClientTests,
	#superclass : #TestCase,
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #debugging }
XMLRPCClientTests >> assertEquals: ob to: other msg: msg [ 
	"Make sure the two objects are equal."
	ob = other
		ifFalse: [self signalFailure: msg , ' (expected ' , ob asString , ', got ' , other asString , ')']
]

{ #category : #debugging }
XMLRPCClientTests >> assertNil: ob withMessage: msg [ 
	"Verify the provided object is nil."
	ob
		ifNotNil: [self signalFailure: msg , ' (expected nil, wasn''t)']
]

{ #category : #debugging }
XMLRPCClientTests >> assertNotNil: ob withMessage: msg [ 
	"Verify the provided objects is not nil."
	ob
		ifNil: [self signalFailure: msg , ' (expected not nil, was)']
]

{ #category : #debugging }
XMLRPCClientTests >> assertSame: ob to: otherOb withMessage: msg [ 
	"Verify the two objects represent the same instance."
	ob == otherOb
		ifFalse: [self signalFailure: msg , ' (expected ' , ob asString , ', got ' , otherOb asString , ')']
]
