"
This header is specific for topic handshake it may have to many things from ROS needs, but time will tell us more about this. 
"
Class {
	#name : #MDDSHandshakeHeader,
	#superclass : #MDDSAbstractDTO,
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> = anOtherHeader [
	^ (anOtherHeader isKindOf: MDDSHandshakeHeader) and: [ self attributes asSet = anOtherHeader attributes asSet ]
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> asString [
	^ self attributes inject: '****** header ******' into: [ :acc :each | acc , String lf , each asString ]
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> attribute: aName [
	^ self attributes detect: [ :attr | attr name = aName ] ifNone: nil
]

{ #category : #accessing }
MDDSHandshakeHeader >> attributes [
	^ self getAt: #attributes
]

{ #category : #accessing }
MDDSHandshakeHeader >> attributes: aValue [
	^ self at: #attributes put: aValue
]

{ #category : #accessing }
MDDSHandshakeHeader >> callerId: aValue [
	self attributes add: (MDDSHeaderAtribute name: 'callerid' value: aValue)
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> initialize [
	super initialize.
	self attributes: OrderedCollection new
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> latching [
	^ (self attribute: 'latching') value
]

{ #category : #accessing }
MDDSHandshakeHeader >> latching: aValue [
	(self attribute: 'latching')
		ifNil: [ self attributes add: (MDDSHeaderAtribute name: 'latching' value: aValue) ]
		ifNotNil: [ :val | val value: aValue ]
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> loadFrom: aConnectionPetition [
	self
		callerId: aConnectionPetition participant name;
		latching: aConnectionPetition latching;
		topic: aConnectionPetition topic name;
		type: aConnectionPetition topic type name;
		md5sum: aConnectionPetition topic type md5sum;
		message_definition: aConnectionPetition topic type plainDefinition
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> md5sum [
	^ (self attribute: 'md5sum') value.
]

{ #category : #accessing }
MDDSHandshakeHeader >> md5sum: aValue [
	(self attribute: 'md5sum')
		ifNil: [ self attributes add: (MDDSHeaderAtribute name: 'md5sum' value: aValue) ]
		ifNotNil: [ :val | val value: aValue ]
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> message_definition [
	^ (self attribute: 'message_definition') value.
]

{ #category : #accessing }
MDDSHandshakeHeader >> message_definition: aValue [
	self attributes add: (MDDSHeaderAtribute name: 'message_definition' value: aValue)
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> printOn: aStream [
	self asString printOn: aStream
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> topic [
	^ (self attribute: 'topic') value
]

{ #category : #accessing }
MDDSHandshakeHeader >> topic: aValue [
	(self attribute: 'topic')
		ifNil: [ self attributes add: (MDDSHeaderAtribute name: 'topic' value: aValue) ]
		ifNotNil: [ :val | val value: aValue ]
]

{ #category : #'as yet unclassified' }
MDDSHandshakeHeader >> type [
	^ (self attribute: 'type') value.
]

{ #category : #accessing }
MDDSHandshakeHeader >> type: aValue [
	(self attribute: 'type')
		ifNil: [ self attributes add: (MDDSHeaderAtribute name: 'type' value: aValue) ]
		ifNotNil: [ :val | val value: aValue ]
]
