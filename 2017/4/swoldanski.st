testCheckPassphrase
	"To ensure security, a valid passphrase must contain no duplicate words."

	self assert: (Day4 checkPassphrase: 'aa bb cc dd ee') equals: true.
	self assert: (Day4 checkPassphrase: 'aa bb cc dd aa') equals: false.
	self assert: (Day4 checkPassphrase: 'aa bb cc dd aaa') equals: true.



testCountValidPassphrases
	"To ensure security, a valid passphrase must contain no duplicate words."

	self assert: (Day4 countValidPassphrases: 
	'aa bb cc dd ee
	aa bb cc dd aa
	aa bb cc dd aaa') equals: 2.



checkPassphrase: aString 
	"A new system policy has been put in place that requires all accounts to use a passphrase instead of simply a password. A passphrase consists of a series of words (lowercase letters) separated by spaces.

To ensure security, a valid passphrase must contain no duplicate words.

For example:

aa bb cc dd ee is valid.
aa bb cc dd aa is not valid - the word aa appears more than once.
aa bb cc dd aaa is valid - aa and aaa count as different words."

	| substrings substringsSet |
	
	substrings := aString substrings .
	substringsSet := substrings asSet .
	
	^ substrings size = substringsSet size.



countValidPassphrases: anInput
	"To ensure security, a valid passphrase must contain no duplicate words."
	
	| validPassphrases |
	
	validPassphrases := 0.
	anInput linesDo: [ :line |
		 (self checkPassphrase: line) 
			ifTrue: [ validPassphrases := validPassphrases + 1]].
		
	^ validPassphrases .



testCheckPassphraseWithoutAnagrams
	"For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase."

	self assert: (Day4 checkPassphraseWithoutAnagrams: 'abcde fghij') equals: true.
	self assert: (Day4 checkPassphraseWithoutAnagrams: 'abcde xyz ecdab') equals: false.
	self assert: (Day4 checkPassphraseWithoutAnagrams: 'a ab abc abd abf abj') equals: true.
	self assert: (Day4 checkPassphraseWithoutAnagrams: 'iiii oiii ooii oooi oooo') equals: true.
	self assert: (Day4 checkPassphraseWithoutAnagrams: 'oiii ioii iioi iiio') equals: false.


testCountValidPassphrasesWithoutAnagrams
	"For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase."

	self assert: (Day4 countValidPassphrasesWithoutAnagrams: 
	'abcde fghij
	abcde xyz ecdab
	a ab abc abd abf abj
	iiii oiii ooii oooi oooo
	oiii ioii iioi iiio') equals: 3.



checkPassphraseWithoutAnagrams: aString 
	"For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.

For example:

abcde fghij is a valid passphrase.
abcde xyz ecdab is not valid - the letters from the third word can be rearranged to form the first word.
a ab abc abd abf abj is a valid passphrase, because all letters need to be used when forming another word.
iiii oiii ooii oooi oooo is valid.
oiii ioii iioi iiio is not valid - any of these words can be rearranged to form any other word.

Under this new system policy, how many passphrases are valid?"

	| substrings substringsSet |
	
	substrings := aString substrings collect: [ :str | str sorted].
	substringsSet := substrings asSet .
	
	^ substrings size = substringsSet size. 



countValidPassphrasesWithoutAnagrams: anInput
	"For added security, yet another system policy has been put in place. Now, a valid passphrase must contain no two words that are anagrams of each other - that is, a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase."
	
	| validPassphrases |
	
	validPassphrases := 0.
	anInput linesDo: [ :line |
		 (self checkPassphraseWithoutAnagrams: line) 
			ifTrue: [ validPassphrases := validPassphrases + 1]].
		
	^ validPassphrases .
