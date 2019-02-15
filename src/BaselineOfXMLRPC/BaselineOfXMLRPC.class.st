Class {
	#name : #BaselineOfXMLRPC,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMLRPC
}

{ #category : #baselines }
BaselineOfXMLRPC >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "use the up-to-date XMLParser project"
			self xmlparser: spec.
			self pragmatic: spec.
			spec
				package: 'XMLRPC-Client-Core'
					with: [ spec requires: #('XMLParser') ];
				package: 'XMLRPC-Client-Tests'
					with: [ spec
						requires: 'XMLRPC-Client-Core';
						requires: 'XMLRPC-Server-Core' ];
				package: 'XMLRPC-Server-Core'
					with: [ spec requires: 'XMLRPC-Client-Core' ];
				package: 'XMLRPC-Server-Tests'
					with: [ spec requires: 'XMLRPC-Server-Core' ].
			spec
				group: 'default' with: 'Client';
				group: 'All' with: #(ClientTests ServerTests);
				group: 'Client' with: #('XMLRPC-Client-Core' Pragmatic);
				group: 'ClientTests' with: #(Client 'XMLRPC-Client-Tests');
				group: 'Server' with: #('XMLRPC-Server-Core' Pragmatic);
				group: 'ServerTests' with: #(Server 'XMLRPC-Server-Tests') ]
]

{ #category : #baselines }
BaselineOfXMLRPC >> pragmatic: spec [
	spec
		baseline: 'Pragmatic'
		with: [ spec repository: 'github://sbragagnolo/Pragmatic/src' ]
]

{ #category : #baselines }
BaselineOfXMLRPC >> xmlparser: spec [
	spec
		project: 'XMLParser'
		with: [ spec
				baseline: 'XMLParser'
				with: [ spec repository: 'github://svenvc/XML-Support-Pharo' ] ]
]
