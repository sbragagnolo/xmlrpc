Class {
	#name : #XMLRPCStandardValidator,
	#superclass : #Object,
	#category : #'XMLRPC-Server-Tests'
}

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> addTests [
	"XMLRPCStandardValidator addTests"

	XMLRPCService atPort: 8081 serve: 
	{
		'validator1.arrayOfStructsTest' -> { self-> #arrayOfStructsTest:}.
		'validator1.countTheEntities'  ->  { self ->  #countTheEntities:}.
		'validator1.echoStructTest'  ->  { self ->  #echoStructTest:}.
		'validator1.easyStructTest'  ->  { self  ->  #easyStructTest:}.
		'validator1.moderateSizeArrayCheck'  ->  { self ->  #moderateSizeArrayCheck:}.
		'validator1.nestedStructTest'  ->  { self ->  #nestedStructTest:}.
		'validator1.simpleStructReturnTest'  ->  { self ->  #simpleStructReturnTest:}.
		'validator1.manyTypesTest'  ->  { self ->  #manyTypesTest: }.	
	} asXMLRPCHttpModule at:'/'.
	

]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> arrayOfStructsTest: aCollection [ 
	| ret |
	ret := 0.
	aCollection first	do: [:each | ret := ret
								+ (each at: 'curly')].
	^ ret
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> countTheEntities: aCollection [ 
	| ret string |
	ret := Dictionary new.
	string := aCollection first.
	ret
		at: 'ctLeftAngleBrackets'
		put: (string occurrencesOf: $<).
	ret
		at: 'ctRightAngleBrackets'
		put: (string occurrencesOf: $>).
	ret
		at: 'ctAmpersands'
		put: (string occurrencesOf: $&).
	ret
		at: 'ctApostrophes'
		put: (string occurrencesOf: $').
	ret
		at: 'ctQuotes'
		put: (string occurrencesOf: $").
	^ ret
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> easyStructTest: aCollection [
	| ret |
	ret := 0. aCollection first valuesDo: [ :each | ret := ret + each ].
	^ret
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> echoStructTest: aDictionary [ 

	^ aDictionary
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> manyTypesTest: aCollection [
    "simply return the decoded values in aCollection encoded"
	| arr x | 
	x := 1.
	arr := Array new: 6.
	aCollection do: [ :each | arr at: x put: each. x := x+1].
	^arr 
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> moderateSizeArrayCheck: aCollection [ 
	| arr |
	arr := aCollection first.
	^ (arr first), (arr last)
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> nestedStructTest: aCollection [
	| struct ret |
	struct := aCollection first.
	ret := 0.
	(((struct at: '2000') at: '04') at: '01') valuesDo: [ :each | ret := ret + each].
	^ ret
]

{ #category : #'as yet unclassified' }
XMLRPCStandardValidator class >> simpleStructReturnTest: aCollection [ 
	| num dict |
	dict := Dictionary new.
	num := aCollection first.
	dict at: 'times10' put: num * 10;
		 at: 'times100' put: num * 100;
		 at: 'times1000' put: num * 1000.
	^ dict
]
