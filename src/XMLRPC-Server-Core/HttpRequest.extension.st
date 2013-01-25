Extension { #name : #HttpRequest }

{ #category : #'*xmlrpc-server-core' }
HttpRequest >> contents [
	^ self rawPostFields.
]
