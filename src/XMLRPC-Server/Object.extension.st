Extension { #name : #Object }

{ #category : #'*xmlrpc-server' }
Object >> asXMLRPCString [
	"answer a XMLRPC struct that includes all instanceVariables of the 
	receiver. A XMLRPC struct is represented as a dictionary in squeak"
	| d |
	d _ Dictionary new.
	self class instVarNames
		do: [:each | d
				at: each asSymbol
				put: (self instVarNamed: each)].
	d size > 0 ifTrue: [^ d asXMLRPCString].
	^'<value>nil</value>'
]
