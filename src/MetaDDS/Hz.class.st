"
A Hz is neasure that represents times per seconds
"
Class {
	#name : #Hz,
	#superclass : #Object,
	#instVars : [
		'timesPerSecond'
	],
	#category : #'MetaDDS-Util'
}

{ #category : #'as yet unclassified' }
Hz class >> tps: aNumber [
	^ self new timesPerSecond: aNumber; yourself
]

{ #category : #'as yet unclassified' }
Hz >> cycle [
	^ (1 / timesPerSecond) asSeconds. 
]

{ #category : #'as yet unclassified' }
Hz >> cycleDelay [
	^ self cycle asDelay.
]

{ #category : #'as yet unclassified' }
Hz >> timesPerSecond: aNumber [
	timesPerSecond  := aNumber
]
