"
Since the ROS protocol is the base of the simple DDS protocol, the implementation by default is the same, but it changes the name
"
Class {
	#name : #ROSTCPProtocol,
	#superclass : #DDSTCPProtocol,
	#category : #'ROSDDS-Protocolo'
}

{ #category : #'as yet unclassified' }
ROSTCPProtocol >> name [ 
	^ 'TCPROS'.
]
