testChecksumPhase1
	"For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences."

	self assert: (Day2 checksumPhase1: 
	'5 1 9 5
	7 5 3
	2 4 6 8') equals: 18.
	
	self assert: (Day2 checksumPhase1: 
	'35 12 94 51
	74 53 3
	2 45 62 8') equals: 213.



testChecksumPhase2
	"It sounds like the goal is to find the only two numbers in each row where one evenly divides the other - that is, where the result of the division operation is a whole number. They would like you to find those numbers on each line, divide them, and add up each line's result."

	self assert: (Day2 checksumPhase2: 
	'5 9 2 8
	9 4 7 3
	3 8 6 5') equals: 9.
	
	self assert: (Day2 checksumPhase2: 
	'35 12 94 60
	74 53 3 2
	2 45 62 11') equals: 73.



Day2 checksumPhase1: anInput
	"The spreadsheet consists of rows of apparently-random numbers. To make sure the recovery process is on the right track, they need you to calculate the spreadsheet's checksum. For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.

For example, given the following spreadsheet:

5 1 9 5
7 5 3
2 4 6 8
The first row's largest and smallest values are 9 and 1, and their difference is 8.
The second row's largest and smallest values are 7 and 3, and their difference is 4.
The third row's difference is 6.
In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18."

	| rows numbers sum |
	
	numbers := OrderedCollection new.
	sum := 0.
	rows := OrderedCollection new.
	
	anInput linesDo: [ :line | 
			numbers := line substrings collect: [ :token | token asNumber ].
			rows add: numbers max - numbers min ].
	
	rows do: [ :number | sum := sum + number ].
	
	^ sum



Day2 checksumPhase2: anInput
	"It sounds like the goal is to find the only two numbers in each row where one evenly divides the other - that is, where the result of the division operation is a whole number. They would like you to find those numbers on each line, divide them, and add up each line's result.

For example, given the following spreadsheet:

5 9 2 8
9 4 7 3
3 8 6 5
In the first row, the only two numbers that evenly divide are 8 and 2; the result of this division is 4.
In the second row, the two numbers are 9 and 3; the result is 3.
In the third row, the result is 2.
In this example, the sum of the results would be 4 + 3 + 2 = 9.

This code really needs refactoring."

	| divisionResults numbers sum |
	
	numbers := OrderedCollection new.
	sum := 0.
	divisionResults := OrderedCollection new.
	
	anInput linesDo: [ :line | 
			numbers := line substrings collect: [ :token | token asNumber ].
			divisionResults add: 
			(numbers collect: [ :num1 | 
				"Iterate all numbers in row over self"
				numbers collect: [ :num2 |
					| divResult |
					divResult := 0.
					( num1 = num2 ) ifFalse: [ "Skip self"
						( num1 / num2 = ( num1 / num2 ) asInteger ) ifTrue: [
							"Found!" 
							divResult := num1 / num2 ] 
						] ifTrue: [ divResult := 0  ].
					divResult 
				] thenSelect: [ :v | v notNil  ] ]) ].
	
	divisionResults flattened do: [ :row | sum := sum + row].
	
	^ sum


