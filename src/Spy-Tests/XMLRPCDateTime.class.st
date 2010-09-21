"
DateTime object for sending and receiving dates via XML-RPC.

	See the convenience class methods for easily creating instances of this class.
"
Class {
	#name : #XMLRPCDateTime,
	#superclass : #Object,
	#instVars : [
		'date',
		'time'
	],
	#category : #'Spy-XML-RPC'
}

{ #category : #'instance creation' }
XMLRPCDateTime class >> fromDate: d time: t [ 
	"Get a new XMLRPCDateTime instance from the given date and time."
	^ XMLRPCDateTime new date: d;
		 time: t
]

{ #category : #'instance creation' }
XMLRPCDateTime class >> fromISO8601String: s [
	"Get a new XMLRPCDateTime instance from the given ISO8601 string."
	^ XMLRPCDateTime new decodeISO8601: s
]

{ #category : #'instance creation' }
XMLRPCDateTime class >> now [ 
	"Get a new XMLRPCDateTime instance representing the current time."
	^ XMLRPCDateTime new date: (Date today); time: (Time now)
]

{ #category : #private }
XMLRPCDateTime >> = anObject [
	"True if the other object is an XMLRPCDateTime representing the same date and time."

	| rv |
	rv _ false.

	((self class) == (anObject class))
		ifTrue: [ rv _ ( (self date) = (anObject date) ) & ((self time) = (anObject time)) ].

	^ rv 
]

{ #category : #accessing }
XMLRPCDateTime >> date [
	"Get the date portion of the datetime."
	^ date
]

{ #category : #accessing }
XMLRPCDateTime >> date: d [
	"Set the date portion of the datetime."
	date _ d
]

{ #category : #xmlrpc }
XMLRPCDateTime >> decodeISO8601: s [ 
	"Set the date and time in this object by parsing the ISO8601 string."
	| d t Y M D |
	Y _ (s copyFrom: 1 to: 4) asInteger.
	M _ (s copyFrom: 5 to: 6) asInteger.
	D _ (s copyFrom: 7 to: 8) asInteger.
	d _ Date
				newDay: D
				month: M
				year: Y.
	t _ Time readFrom: ((s copyFrom: 10 to: 17) readStream).
	self date: d.
	self time: t
]

{ #category : #xmlrpc }
XMLRPCDateTime >> encodeISO8601 [
	| rv |
	"Encode me into an ISO8601 datetime for XML-RPC"
	rv _ Text new.

	rv append: (date year asString).
	rv append: (self pad: (date monthIndex asString) to: 2 with: '0').
	rv append: (self pad: (date dayOfMonth asString) to: 2 with: '0').
	rv append: 'T'.
	rv append: (time print24).

	^ rv asString
]

{ #category : #private }
XMLRPCDateTime >> hash [
	"Predictable hash for this object."
	^ date hash bitXor: (time hash)
]

{ #category : #private }
XMLRPCDateTime >> pad: in to: preferredSize with: thing [ 
	"Return a string with in padded on the left with the given number of  
	the given thing."
	| rv |
	rv _ Text new.
	rv append: in asString.
	[rv size < preferredSize]
		whileTrue: [rv prepend: thing].
	^ rv asString
]

{ #category : #printing }
XMLRPCDateTime >> printOn: aStream [
	"Send it to the stream."
	aStream nextPutAll: (self encodeISO8601).
]

{ #category : #accessing }
XMLRPCDateTime >> time [
	"Get the time portion of the datetime."
	^ time
]

{ #category : #accessing }
XMLRPCDateTime >> time: t [
	"set the time portion of the datetime."
	time _ t
]
