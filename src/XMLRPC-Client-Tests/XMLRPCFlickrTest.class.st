"
https://www.flickr.com/services/api/
https://www.flickr.com/services/api/response.xmlrpc.html
https://www.flickr.com/services/api/flickr.test.echo.html
"
Class {
	#name : #XMLRPCFlickrTest,
	#superclass : #XMLRPCClientBaseTest,
	#instVars : [
		'proxy',
		'apiname',
		'apikey'
	],
	#category : #'XMLRPC-Client-Tests'
}

{ #category : #running }
XMLRPCFlickrTest >> setUp [
	"This class try to test some xmlrpc methods exposed by Flickr. You need internet connection:"
	| url |
	
	url := ZnUrl fromString: 'https://api.flickr.com/services/xmlrpc/'.

	proxy := XMLRPCProxy new url: url.

	" Flickr key to xmlrpc project. Please use them carefully"

	apiname := 'f325ea24350b657d'.
	apikey := '8ba79f0125a2e9d1f82ebb9cac40d68a'.
	
	^ self
]

{ #category : #tests }
XMLRPCFlickrTest >> testEchoFlickr [
	"Test struct call to Flickrecho service"
	| d r |


	d := Dictionary new.
	d at: 'name' put: apiname.
	d at: 'api_key' put: apikey.

	r := proxy invokeMethod: 'flickr.test.echo' withStruct: d.
	
	"Quick test to check if the returned ByteString contains the same key value and secret passed"
	"Only one of both is needed"
	self shouldnt: [ r findString: '8ba79f0125a2e9d1f82ebb9cac40d68a' ] raise: 0.
	self shouldnt: [ r findString: 'f325ea24350b657d' ] raise: 0.
	
]
