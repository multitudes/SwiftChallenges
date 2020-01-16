/*:
 [Previous](@previous)

# Challenge 2: Is a string a palindrome?

## Difficulty: Easy

Write a function that accepts a String as its only parameter, and returns true if the string
reads the same when reversed, ignoring case.


 [Next](@next)
*/

import Foundation

// At first I tried with reversed but did not work for some reason, so i took this solution
func challenge2a(input: String) -> Bool {
    let inputArray = Array(input.lowercased())
    let count = inputArray.count - 1
    for i in 0..<count / 2 {
        if inputArray[i] != inputArray[count - i]{
        return false
        }
    }
    return true
}
// but reversed does work!
func challenge2(input: String) -> Bool {
    let lowercase = input.lowercased()
    return lowercase.reversed() == Array(lowercase)
}

 //These four assert() statements should all evaluate to true, and therefore not trigger an error:
assert(challenge2(input: "rotator") == true, "Challenge 2 failed")
assert(challenge2(input: "Rats live on no evil star") == true, "Challenge 2 failed")
assert(challenge2(input: "Never odd or even") == false, "Challenge 2 failed")
assert(challenge2(input: "Hello, world") == false, "Challenge 2 failed")
