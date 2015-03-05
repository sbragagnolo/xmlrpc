Extension { #name : #DDSRemoteDomainMirror }

{ #category : #'*ROSDDS' }
DDSRemoteDomainMirror >> findServiceByName: aServiceName [
	^ proxy findServiceByName: aServiceName
]

{ #category : #'*ROSDDS' }
DDSRemoteDomainMirror classSide >> onROS: anURL [
	^ self  on: (ROSDomainProxy on: anURL )
]
