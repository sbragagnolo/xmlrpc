"
The request Class wasn't found
"
Class {
	#name : #XMLRPCClassNotFoundError,
	#superclass : #XMLRPCError,
	#category : #'XMLRPC-Server-Errors'
}

{ #category : #'as yet unclassified' }
XMLRPCClassNotFoundError >> faultCode [
	^ 1
]
