"
This is a generic error, it is raised if an unknown error has been detected.
"
Class {
	#name : #XMLRPCError,
	#superclass : #Error,
	#instVars : [
		'faultCode'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #accessing }
XMLRPCError >> faultCode [
	"Answer the receiver's 'faultCode'."
	^ faultCode ifNil: [ ^0]
]

{ #category : #accessing }
XMLRPCError >> faultCode: anObject [
	"Set the receiver's instance variable 'faultCode' to be anObject."

	faultCode := anObject
]
