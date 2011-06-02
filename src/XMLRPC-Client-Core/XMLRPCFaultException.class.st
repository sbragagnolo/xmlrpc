"
Exception thrown to indicate an XML-RPC fault.
"
Class {
	#name : #XMLRPCFaultException,
	#superclass : #XMLRPCException,
	#instVars : [
		'faultCode',
		'faultMessage'
	],
	#category : #'XMLRPC-Client-Core'
}

{ #category : #signaling }
XMLRPCFaultException class >> signal: faultCode withMessage: faultMessage [ 
	"Signal an XMLRPC fault with the given fault code and message."
	XMLRPCFaultException new faultCode: faultCode ; faultMessage: faultMessage ; signal: faultMessage
]

{ #category : #accessing }
XMLRPCFaultException >> faultCode [
	"Get the fault code."
	^ faultCode
]

{ #category : #accessing }
XMLRPCFaultException >> faultCode: to [
	"Set the fault code to the given value."
	faultCode := to
]

{ #category : #accessing }
XMLRPCFaultException >> faultMessage [
	"Get the fault message."
	^ faultMessage
]

{ #category : #accessing }
XMLRPCFaultException >> faultMessage: to [
	"Set the fault message to the given value."
	faultMessage := to
]
