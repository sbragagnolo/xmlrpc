"
This is an abstract class for objects that are bidirectionally related with topics, under the relation of usage or interaction.
"
Class {
	#name : #MDDSTopicInteractor,
	#superclass : #MDDSEntity,
	#instVars : [
		'topic'
	],
	#category : #'MetaDDS-Kernel'
}

{ #category : #constructor }
MDDSTopicInteractor class >> domain: aMDDSDomain named: aName on: aMDDSTopic [ 
	^ (super domain: aMDDSDomain name: aName) topic: aMDDSTopic; yourself. 
]

{ #category : #accessing }
MDDSTopicInteractor >> topic [
	^ topic.
]

{ #category : #accessing }
MDDSTopicInteractor >> topic: aMDDSTopic [ 
	topic := aMDDSTopic.
]
