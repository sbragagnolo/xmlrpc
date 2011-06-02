Class {
	#name : #XMLRPCMethodError,
	#superclass : #XMLRPCError,
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCMethodError >> faultCode [
	^ 2
]
