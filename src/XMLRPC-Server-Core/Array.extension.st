Extension { #name : #Array }

{ #category : #'*xmlrpc-server-core' }
Array >> asXMLRPCHttpModule [
	^ XMLRPCHttpModule for: self asDictionary.
]
