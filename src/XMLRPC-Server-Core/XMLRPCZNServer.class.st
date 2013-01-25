Class {
	#name : #XMLRPCZNServer,
	#superclass : #XMLRPCServer,
	#category : #'XMLRPC-Server-Core'
}

{ #category : #'as yet unclassified' }
XMLRPCZNServer >> createServer [
	| delegate |
	
	server := ZnServer on: self port.
	delegate := ZnDispatcherDelegate new.
	
	modules keysAndValuesDo: [
		:key :value | 
		delegate map: key to: [ :request :response |  
			response entity: (ZnStringEntity xml: (value process: request)) ] .	
	].

	server delegate: delegate.
	

]

{ #category : #'as yet unclassified' }
XMLRPCZNServer >> stop [
	server ifNotNil: [
		server stop.
		server := nil
	].
]
