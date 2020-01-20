/*:
 [Previous](@previous)

#  Challenge 13: Run-length encoding
 
## Difficulty: Tricky
 
 Write a function that accepts a string as input, then returns how often each letter is repeated in
 a single run, taking case into account.
 Tip: This approach is used in a simple lossless compression technique called run-length encoding.

 Sample input and output
 • The string “aabbcc” should return “a2b2c2”.
 • The strings “aaabaaabaaa” should return “a3b1a3b1a3”
 • The string “aaAAaa” should return “a2A2a2”
 
 [Next](@next)
*/

import Foundation

func challenge13(_ string: String) -> String {
    var count = 0
    var result = ""
    var currentChar: Character?
    for char in string {
        if currentChar != nil  {
            if currentChar != char {
                result.append(currentChar!)
                result.append(String(count))}
        }
        if char == currentChar {
            count += 1
            continue
        }
        currentChar = char
        count = 1
    }
    result.append(currentChar!)
    result.append(String(count))
    return result
}

    challenge13("aaab")
    challenge13("aaAAaa")
    

// second solution by paul
func challenge13b(_ input: String) -> String {
    var returnValue = ""
    var letterCounter = 0
    var letterArray = Array(input)
    
    for i in 0 ..< letterArray.count {
        letterCounter += 1
        if i + 1 == letterArray.count || letterArray[i] != letterArray[i + 1] {
            returnValue += "\(letterArray[i])\(letterCounter)"
            letterCounter = 0
        }
}
   return returnValue
}


challenge13b("aaab")
challenge13b("aaAAaa")

assert(challenge13("aabbcc") == "a2b2c2", "fail")
assert(challenge13("aaabaaabaaa") == "a3b1a3b1a3", "fail")
assert(challenge13("aaAAaa") == "a2A2a2", "fail")

assert(challenge13b("aabbcc") == "a2b2c2", "fail")
assert(challenge13b("aaabaaabaaa") == "a3b1a3b1a3", "fail")
assert(challenge13b("aaAAaa") == "a2A2a2", "fail")


/*:
 [Previous](@previous)

#  Challenge 14: String permutations
 
## Difficulty: Taxing
 
 Write a function that prints all possible permutations of a given input string.
 Tip: A string permutation is any given rearrangement of its letters, for example “boamtw” is a permutation of “wombat”.
 Sample input and output
 • The string “a” should print “a”.
 • The string “ab” should “ab”, “ba”.
 • The string “abc” should print “abc”, “acb”, “bac”, “bca”, “cab”, “cba”.
 • The string “wombat” should print 720 permutations.

 
 [Next](@next)
*/

// count is just to check the factorial! number of outputs..
var count = 0
func challenge14(_ string: String, current: String = "") -> Int {
    
    let length = string.count
    let strArray = Array(string)
    
    if length == 0 {
        count += 1
        print(count)
        print(current)
        print("****")
    }
    for i in 0..<length {
        let left = String(strArray[0..<i])
        let right = String(strArray[i+1..<length])
        challenge14(left + right, current: current + String(strArray[i]))
    }
return count
}

challenge14("abc")
count = 0
challenge14("a")
count = 0
assert(challenge14("a") == 1, "fail")
count = 0
assert(challenge14("ab") == 2, "fail")
count = 0
assert(challenge14("abc") == 6, "fail")
count = 0
assert(challenge14("wombat") == 720, "fail")



func challenge15(_ string: String) -> String {

    let parts = string.components(separatedBy: " ")
    let reversed = parts.map { String($0.reversed()) }
    return reversed.joined(separator: " ")
}

challenge15("abc cba")

assert(challenge15("Swift Coding Challenges") == "tfiwS gnidoC segnellahC", "fail")
assert(challenge15("The quick brown fox") == "ehT kciuq nworb xof", "fail")
