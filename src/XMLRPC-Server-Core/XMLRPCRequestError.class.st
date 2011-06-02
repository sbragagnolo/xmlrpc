"
An error raised if a malformed request was found
"
Class {
	#name : #XMLRPCRequestError,
	#superclass : #XMLRPCError,
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCRequestError >> faultCode [
	^ 3
]
