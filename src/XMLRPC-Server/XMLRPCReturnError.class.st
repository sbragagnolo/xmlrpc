"
An error occured while encoding a methodresponse
"
Class {
	#name : #XMLRPCReturnError,
	#superclass : #XMLRPCError,
	#category : #'XMLRPC-Server-Errors'
}

{ #category : #'as yet unclassified' }
XMLRPCReturnError >> faultCode [
	^ 4
]
