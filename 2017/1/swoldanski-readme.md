### Documentation

http://pharo.org


### TDD rulez!!!

    testDay1Solutions
        "TDD is real!!"

        self assert: (Day1 captcha1: '1122') equals: 3.
        self assert: (Day1 captcha1: '1111') equals: 4.
        self assert: (Day1 captcha1: '1234') equals: 0.
        self assert: (Day1 captcha1: '91212129') equals: 9.
        self assert: (Day1 captcha2: '1212') equals: 6.
        self assert: (Day1 captcha2: '1221') equals: 0.
        self assert: (Day1 captcha2: '123425') equals: 4.
        self assert: (Day1 captcha2: '123123') equals: 12.
        self assert: (Day1 captcha2: '12131415') equals: 4


### Solution class

    Day1 class

    captcha2: aString
    "Solution: Just iterate over doubled string and compare current char with char at shifted position."

        | counter distToCompare aStringToWorkAt |

        counter := 0.
        distToCompare := aString size / 2.
        aStringToWorkAt := aString , aString.

        1 to: aString size do: [ :index | 
        
            | element toCompare |
        
            toCompare := aStringToWorkAt  at: distToCompare + index.
            element := aStringToWorkAt at: index.
            toCompare = element ifTrue: [ counter := counter + element asText asNumber ] 
        ].
        
        ^ counter


    captcha1: aString
        "Solution: 
            Just iterate over string and compare current char with previous.
            At the end check first and last char and add value to counter if needed"
            
        | counter firstNumber currentNumber |
        
        counter := 0.
        currentNumber := $_.
        
        aString do: [ :element |
            currentNumber = element ifTrue: [ counter := counter + element asText asNumber ].
            currentNumber := element 
        ].
        
        firstNumber := aString first.
        firstNumber = aString last ifTrue: [ counter := counter + firstNumber asText asNumber ].
        
        ^ counter

