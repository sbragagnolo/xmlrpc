Extension { #name : #Object }

{ #category : #'*MetaDDS' }
Object class >> allInstVarNamesForEqualityComparison [
	^self superclass allInstVarNamesForEqualityComparison, self instVarNamesForEqualityComparison
]

{ #category : #'*MetaDDS' }
Object class >> instVarNamesForEqualityComparison [
	^self instVarNames
]

{ #category : #'*MetaDDS' }
Object >> instVarNamesForEqualityComparison [
	^self class allInstVarNamesForEqualityComparison
]

{ #category : #'*MetaDDS' }
Object >> valuesToCompareForEquality [
	^self instVarNamesForEqualityComparison collect: [:ivName|
		self instVarNamed: ivName]
]
