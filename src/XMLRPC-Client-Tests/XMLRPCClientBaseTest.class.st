"
Unit test framework.
"
Class {
	#name : #XMLRPCClientBaseTest,
	#superclass : #TestCase,
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #asserting }
XMLRPCClientBaseTest >> assertEquals: ob to: other msg: msg [ 
	"Make sure the two objects are equal."
	ob = other
		ifFalse: [self signalFailure: msg , ' (expected ' , ob asString , ', got ' , other asString , ')']
]

{ #category : #asserting }
XMLRPCClientBaseTest >> assertNil: ob withMessage: msg [ 
	"Verify the provided object is nil."
	ob
		ifNotNil: [self signalFailure: msg , ' (expected nil, wasn''t)']
]

{ #category : #asserting }
XMLRPCClientBaseTest >> assertNotNil: ob withMessage: msg [ 
	"Verify the provided objects is not nil."
	ob
		ifNil: [self signalFailure: msg , ' (expected not nil, was)']
]

{ #category : #asserting }
XMLRPCClientBaseTest >> assertSame: ob to: otherOb withMessage: msg [ 
	"Verify the two objects represent the same instance."
	ob == otherOb
		ifFalse: [self signalFailure: msg , ' (expected ' , ob asString , ', got ' , otherOb asString , ')']
]
