Extension { #name : #DDSExternallyDefinedDomain }

{ #category : #'*ROSDDS' }
DDSExternallyDefinedDomain classSide >> onROS: anUrl [
	^ self on: (DDSRemoteDomainMirror onROS: anUrl)
]
