"
This class holds all information about a XMLRPC request an coordinates the computation of a XMLRPC methodcall
"
Class {
	#name : #XMLRPCServerRequest,
	#superclass : #Object,
	#instVars : [
		'methodCall',
		'params',
		'targetURI'
	],
	#classVars : [
		'Receivers'
	],
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> cleanUpReceiverDictionary [
	" deletes references to obsolete classes from the 'Receivers' dictionary"
	| removeThem |
	
	self debug: ['Cleaning up receiving dictionary: ' , self receivers ].
	removeThem := self receivers 	select: [ : each | each isObsolete ].
	removeThem keysDo: [ : key | self receivers removeKey: key ].
	
]

{ #category : #'class initialization' }
XMLRPCServerRequest class >> initialize [
	Receivers := Dictionary new.
]

{ #category : #accessing }
XMLRPCServerRequest class >> receivers [
	^Receivers ifNil: [Receivers := Dictionary new].
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> registerService: serviceName class: aClass selector: aSelector [ 
	self receivers at: serviceName asSymbol put: aClass -> aSelector
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> removeAllServices [
	self receivers removeAll.
]

{ #category : #'as yet unclassified' }
XMLRPCServerRequest class >> removeService: aXMLRPCService [
	self receivers removeKey: aXMLRPCService asSymbol
]

{ #category : #accessing }
XMLRPCServerRequest >> methodCall [
	"Answer the receiver's 'methodCall'."

	^methodCall
]

{ #category : #accessing }
XMLRPCServerRequest >> methodCall: anObject [
	"Set the receiver's instance variable 'methodCall' to be anObject."

	methodCall := anObject
]

{ #category : #accessing }
XMLRPCServerRequest >> params [
	"Answer the receiver's 'params'."

	^params
]

{ #category : #accessing }
XMLRPCServerRequest >> params: anObject [
	"Set the receiver's instance variable 'params' to be anObject."

	params := anObject
]

{ #category : #accessing }
XMLRPCServerRequest >> targetURI [
	"Answer the receiver's 'targetURI'."

	^targetURI
]

{ #category : #accessing }
XMLRPCServerRequest >> targetURI: anObject [
	"Set the receiver's instance variable 'targetURI' to be anObject."

	targetURI := anObject
]
