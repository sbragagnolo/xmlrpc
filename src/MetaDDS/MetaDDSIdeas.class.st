"
Testing:

	TODO: Test that all what is mirror is mirror and what is concrete it is actually concrete.
	

Implement

	Local master - just for pharo. 
	Local master - just for pharo - ros compatible. 
"
Class {
	#name : #MetaDDSIdeas,
	#superclass : #Object,
	#category : #MetaDDS
}

{ #category : #'as yet unclassified' }
MetaDDSIdeas >> publisher [
"SUBSCRIBER"

| domain mirror participant type adhoc subscription in |
domain := MDDSExternallyDefinedDomain onROS: 'http://127.0.0.1:11311/'.
mirror := domain mirror . 


participant := MDDSDomainParticipant domain: domain name: 'adhoc-participant' ip: '127.0.0.1'.

type :=  MDDSTypeDescriptor domain: domain name: 'std_msgs/Int16'.

adhoc := (MDDSTopicDescriptor domain: domain name: '/adhoc'  type: type) createTopic.

domain addProtocol: (DDSTCPProtocol encoding: MDDSEncoder  decoding: MDDSDecoder).


subscription := adhoc subscriber forParticipant: participant onRead: [ 
 : packet |
	self halt. 	
 ].


in := DDSParticipantProxy on: 'http://127.0.0.1:10000'. 


in proxy requestFor: ' name 'theTopic: '/adhoc' withProtocol: { 'TCPROS'}. 


type := subscription := mirror := domain := participant := adhoc := nil.

XMLRPCService stopAll.

TKTRunner allSubInstances do: #cancel.


MDDSPublication allInstances
 do:#stopPublishing.
DDSPublicationServer allInstances do:#stop.
DDSSParticipantServer allInstances do:#unserve.
Socket allInstances do: #destroy.

MDDSEntity allSubInstances
 do: [ :e | e domain: nil].

MDDSReadingNetworkConnection allInstances 
do: #destroy.


30 timesRepeat: [  Smalltalk garbageCollect  ].


]

{ #category : #'as yet unclassified' }
MetaDDSIdeas >> subscriber [
"SUBSCRIBER"

| domain mirror participant type adhoc subscription in |
domain := MDDSExternallyDefinedDomain onROS: 'http://127.0.0.1:11311/'.
mirror := domain mirror . 


participant := MDDSDomainParticipant domain: domain name: 'adhoc-participant' ip: '127.0.0.1'.

type :=  MDDSTypeDescriptor domain: domain name: 'std_msgs/Int16'.

adhoc := (MDDSTopicDescriptor domain: domain name: '/adhoc'  type: type) createTopic.

domain addProtocol: (DDSTCPProtocol encoding: MDDSEncoder  decoding: MDDSDecoder).


subscription := adhoc subscriber forParticipant: participant onRead: [ 
 : packet |
	self halt. 	
 ].


in := DDSParticipantProxy on: 'http://127.0.0.1:10000'. 


in proxy requestFor: ' name 'theTopic: '/adhoc' withProtocol: { 'TCPROS'}. 


type := subscription := mirror := domain := participant := adhoc := nil.

XMLRPCService stopAll.

TKTRunner allSubInstances do: #cancel.





MDDSPublication allInstances
 do:#stopPublishing.
DDSPublicationServer allInstances do:#stop.
DDSSParticipantServer allInstances do:#unserve.
Socket allInstances do: #destroy.

MDDSEntity allSubInstances
 do: [ :e | e domain: nil].

MDDSReadingNetworkConnection allInstances 
do: #destroy.


30 timesRepeat: [  Smalltalk garbageCollect  ].


]

{ #category : #'as yet unclassified' }
MetaDDSIdeas >> ws [
| mirror domain participant adhoc |

mirror := MDDSRemoteDomainMirror onROS: 'http://dora:11311/'.
domain := mirror domain. 
participant := MDDSDomainParticipant domain: domain name: 'adhoc-participant'.
adhoc := MDDSTopic domain: domain name: '/adhoc'  type: 'std_msgs/Int16'. 
adhoc subscriber forParticipant: participant onRead: [ 
 : packet |
	self halt. 	
 ]


MDDSProtoDomain  allSubInstances.
XMLRPCService stop: 9999.
20 timesRepeat: [  Smalltalk garbageCollect  ].

]
