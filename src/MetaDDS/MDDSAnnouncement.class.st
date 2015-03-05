"
Abstract announcent. It just cuts the default lookup for selectors (check class-side)
"
Class {
	#name : #MDDSAnnouncement,
	#superclass : #Announcement,
	#category : #'MetaDDS-Kernel'
}

{ #category : #'as yet unclassified' }
MDDSAnnouncement class >> handlesAnnouncement: anAnnouncement [
	" All the inheritance in this hierarchy is for convenience and not for real concept. "
	^ anAnnouncement class == self 
]
