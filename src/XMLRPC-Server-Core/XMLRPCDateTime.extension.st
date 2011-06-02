Extension { #name : #XMLRPCDateTime }

{ #category : #'*XMLRPC-Server-Core' }
XMLRPCDateTime >> asXMLRPCString [
	| str |
	str := WriteStream on: (String new: 70).
	str nextPutAll: '<value><dateTime.iso8601>'; nextPutAll:
	self encodeISO8601; nextPutAll: '</dateTime.iso8601></value>';cr.
	^ str contents
]
