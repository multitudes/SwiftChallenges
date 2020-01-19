/*:
 [Previous](@previous)

# Challenge 11: Three different letters

 ## Difficulty: Tricky
 
 Write a function that accepts two strings, and returns true if they are identical in length but
 have no more than three different letters, taking case and string order into account.

 [Next](@next)
*/



import Foundation

func challenge11(_ string1: String, _ string2: String) -> Bool {
    let firstStr = Array(string1)
    let secondStr = Array(string2)
    guard firstStr.count == secondStr.count else { return false }
    
    var count = 0
    for i in 0 ..< firstStr.count{
        if firstStr[i] != secondStr[i] {
            count += 1
        }
        if count > 3 { return false }
    }
    return true
}

challenge11("abc", "abd")

let a = challenge11("abc2", "def3")
assert(challenge11("Clamp", "Cramp") == true, "fail")
assert(challenge11("Clamp", "Crams") == true, "fail")
assert(challenge11("Clamp", "Grams") == true, "fail")
assert(challenge11("Clamp", "Clam") == false, "fail")
assert(challenge11("Clamp", "Grans") == false, "fail")
assert(challenge11("clamp", "maple") == false, "fail")

// another way
func challenge11a(_ string1: String, _ string2: String) -> Bool {
    guard string1.count == string2.count else { return false }
    let firstArray = Array(string1)
    let secondArray = Array(string2)
    var differences = 0
    for (index, letter) in firstArray.enumerated() {
        if secondArray[index] != letter {
    differences += 1
    if differences == 4 { return false  }
        }
    }
    return true
}

challenge11a("abc", "abd")


/*:
 [Previous](@previous)

# Challenge 12: Find longest prefix

 ## Difficulty: Tricky
 
 Write a function that accepts a string of words with a similar prefix, separated by spaces, and
 returns the longest substring that prefixes all words.
 
 Sample input and output
 • The string “swift switch swill swim” should return “swi”.
 • The string “flip flap flop” should return “fl”.

 [Next](@next)
*/

func challenge12(_ string: String) -> String {
    var currentPrefix = ""
    var longestPrefix = ""
    let words = string.components(separatedBy: " ")
        print(words)
    guard let first = words.first else { return "" }
    currentPrefix = String(words[0].first ?? " ")
    longestPrefix = currentPrefix
    for j in 0..<first.count {
        // turns out prefix start counting at one!
        currentPrefix = String(first.prefix(j+1))
        print(currentPrefix)
        for i in 0 ..< words.count {
            if words[i].hasPrefix(currentPrefix) {
                //print(currentPrefix)
                continue
            } else {
                return longestPrefix
            }
        }
            longestPrefix = currentPrefix
    }
    return longestPrefix
}

challenge12("swift switch swill swim")

assert(challenge12("swift switch swill swim") == "swi", " fail")
assert(challenge12("flip flap flop") == "fl", " fail")
assert(challenge12("flip flipflap flipflop") == "flip", " fail")

//and another solution from paul

func challenge12a(_ input: String) -> String {
    let parts = input.components(separatedBy: " ")
    guard let first = parts.first else { return "" }
    var currentPrefix = ""
    var bestPrefix = ""
    for letter in first {
        currentPrefix.append(letter)
        for word in parts {
            if !word.hasPrefix(currentPrefix) {
                return bestPrefix
            }
        }
        bestPrefix = currentPrefix }
    return bestPrefix
}
challenge12a("swift switch swill swim")

// turns out prefix start counting at one!
//print("swim".prefix(4))
