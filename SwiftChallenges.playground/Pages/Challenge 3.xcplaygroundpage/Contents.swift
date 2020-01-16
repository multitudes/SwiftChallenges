/*:
 [Previous](@previous)

# Challenge 3: Do two strings contain the same characters?

## Difficulty: Easy

Write a function that accepts two String parameters, and returns true if they contain the same characters in any order taking into account letter case.


 [Next](@next)
*/

import Foundation

func challenge3(input1: String, input2: String) -> Bool {
    return Array(input1).sorted() == Array(input2).sorted()
}

//These four assert() statements should all evaluate to true, and therefore not trigger an error:
assert(challenge3(input1: "abca", input2: "abca") == true, "Challenge failed")
assert(challenge3(input1: "abc", input2: "cba") == true, "Challenge failed")
assert(challenge3(input1: "a1 b2", input2: "b1 a2") == true, "Challenge failed")
assert(challenge3(input1: "abc", input2: "abca") == false, "Challenge failed")
assert(challenge3(input1: "abc", input2: "Abc") == false, "Challenge failed")
assert(challenge3(input1: "abc", input2: "cbAa") == false, "Challenge failed")
