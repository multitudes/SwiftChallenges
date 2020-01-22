/*:
# Challenge 1: Are the letters unique?

 ### Difficulty: Easy
 Write a function that accepts a String as its only parameter, and returns true if the string has
 only unique letters, taking letter case into account.

: [Next](@next)
*/

import Foundation

func challenge1(input: String) -> Bool {
    // convert input to set of characters
    let uniqueCharacters = Set(input).count
    // count the characters in the input string
    let characters = input.count
    return uniqueCharacters == characters
}


// These four assert() statements should all evaluate to true, and therefore not trigger an error:
assert(challenge1(input: "No duplicates") == true, "Challenge 1 failed")
assert(challenge1(input: "abcdefghijklmnopqrstuvwxyz") == true, "Challenge 1 failed")
assert(challenge1(input: "AaBbCc") == true, "Challenge 1 failed")
assert(challenge1(input: "Hello, world") == false, "Challenge 1 failed")

/*:
 [Previous](@previous)

# Challenge 2: Is a string a palindrome?

### Difficulty: Easy

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

