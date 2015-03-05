"
Since the Simple DDS implementation is based on the ROS implementation, but without the structural installation, the type loader is completely different. And that is the main difference.
"
Class {
	#name : #ROSDomainProxy,
	#superclass : #DDSDomainProxy,
	#category : #'ROSDDS-Proxy'
}

{ #category : #'as yet unclassified' }
ROSDomainProxy >> findParticipantByName: aName [
| uri |
	uri := proxy lookupNode: aName with: '/NotAnActualID'.
	^ DDSParticipantDescriptor domain: nil name: aName uri: uri. 
]

{ #category : #'as yet unclassified' }
ROSDomainProxy >> findServiceByName: aName [
| uri |
	uri := proxy lookupService: aName with: '/NotAnActualID'.
	^ ROSServiceDescriptor domain: nil name: aName uri: uri. 
]

{ #category : #'as yet unclassified' }
ROSDomainProxy >> registerTypeDefinition: aTypeDefinition [
	^ self error: 'ROS bridge does not support type deploying'
]

{ #category : #'as yet unclassified' }
ROSDomainProxy >> systemState [
	^ proxy getSystemState: '/NotAnActualID'
]

{ #category : #'as yet unclassified' }
ROSDomainProxy >> typeLoader [
	^ typeLoader ifNil: [ typeLoader := ROSTypeLoder commandBased ]
]

{ #category : #accessing }
ROSDomainProxy >> url [
	^ proxy url asString
]
