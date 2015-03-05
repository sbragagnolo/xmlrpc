"
A PhaROSTimestamp is wrapper that makes easy to make the conversions between ROS and pharo
"
Class {
	#name : #MDDSTimestamp,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'timestamp'
	],
	#category : #'MetaDDS-TypesMarshalling'
}

{ #category : #'as yet unclassified' }
MDDSTimestamp class >> fromUnixTime: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	^ super new timestamp: ((DateAndTime fromUnixTime: anAmountOfSeconds)  + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ));
				  yourself.
]

{ #category : #'as yet unclassified' }
MDDSTimestamp class >> new [
	^ super new timestamp:( DateAndTime fromUnixTime: 0) ; yourself .
]

{ #category : #'as yet unclassified' }
MDDSTimestamp class >> now [
	^ super new timestamp: DateAndTime now ; yourself .
]

{ #category : #operations }
MDDSTimestamp >> + aDuration [
	^ MDDSTimestamp new timestamp: timestamp + aDuration ; yourself.
]

{ #category : #operations }
MDDSTimestamp >> - aDateAndTime [
	^ timestamp - aDateAndTime asDateAndTime.
]

{ #category : #operations }
MDDSTimestamp >> < aDateAndTime [
	^ timestamp < aDateAndTime asDateAndTime.
]

{ #category : #comparing }
MDDSTimestamp >> = anObject [ 
	self species = anObject species ifFalse: [^false].
	^self valuesToCompareForEquality = anObject valuesToCompareForEquality
]

{ #category : #operations }
MDDSTimestamp >> > aDateAndTime [
	^ timestamp > aDateAndTime asDateAndTime.
]

{ #category : #converting }
MDDSTimestamp >> asDateAndTime [
	^ timestamp
]

{ #category : #comparing }
MDDSTimestamp >> closeTo: anOtherPhaROSTimeStamp [
	^ timestamp = anOtherPhaROSTimeStamp timestamp.
	
]

{ #category : #'as yet unclassified' }
MDDSTimestamp >> fromUnixTime: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	^ super new timestamp: ((DateAndTime fromUnixTime: anAmountOfSeconds)  + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ));
				  yourself.
]

{ #category : #comparing }
MDDSTimestamp >> hash [
	^self valuesToCompareForEquality inject: self species hash into: [:hash :comparisonValue|
		(hash bitXor: comparisonValue hash) hashMultiply]

]

{ #category : #converting }
MDDSTimestamp >> nanoSeconds [
	^ timestamp nanoSecond.
]

{ #category : #'simple instance creation' }
MDDSTimestamp >> nanoSeconds: anAmountOfNSeconds [ 
	timestamp nanoSeconds: anAmountOfNSeconds 
]

{ #category : #'as yet unclassified' }
MDDSTimestamp >> new [
	^ super new timestamp:( DateAndTime fromUnixTime: 0) ; yourself .
]

{ #category : #'as yet unclassified' }
MDDSTimestamp >> now [
	^ super new timestamp: DateAndTime now ; yourself .
]

{ #category : #accessing }
MDDSTimestamp >> seconds [
	^ timestamp asUnixTime .
]

{ #category : #private }
MDDSTimestamp >> seconds: anAmountOfSeconds [
	timestamp seconds: anAmountOfSeconds.
]

{ #category : #private }
MDDSTimestamp >> seconds: anAmountOfSeconds  nanoSeconds: anAmountOfNSeconds [ 
	timestamp := (DateAndTime fromUnixTime: anAmountOfSeconds) + (Time seconds: 0 nanoSeconds: anAmountOfNSeconds ).
	^ timestamp.
]

{ #category : #converting }
MDDSTimestamp >> secondsUTC [
	^ timestamp asUnixTime - (timestamp offset asSeconds).
]

{ #category : #accessing }
MDDSTimestamp >> timestamp [ 
	^ timestamp.
]

{ #category : #accessing }
MDDSTimestamp >> timestamp: aDateAndTime [
	timestamp := aDateAndTime.
	
]
