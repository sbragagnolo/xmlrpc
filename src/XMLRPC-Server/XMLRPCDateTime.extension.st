Extension { #name : #XMLRPCDateTime }

{ #category : #'*xmlrpc-server' }
XMLRPCDateTime >> asXMLRPCString [
	| str |
	str _ WriteStream on: (String new: 70).
	str nextPutAll: '<value><dateTime.iso8601>'; nextPutAll:
	self encodeISO8601; nextPutAll: '</dateTime.iso8601></value>';cr.
	^ str contents
]
