Class {
	#name : #XMLRPCMethodError,
	#superclass : #XMLRPCError,
	#category : #'XMLRPC-Server-Errors'
}

{ #category : #'as yet unclassified' }
XMLRPCMethodError >> faultCode [
	^ 2
]
