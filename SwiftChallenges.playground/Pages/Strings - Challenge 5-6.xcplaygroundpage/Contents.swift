/*:
 [Previous](@previous)

# Challenge 5: Count the characters

### Difficulty: Easy
 Write a function that accepts a string, and returns how many times a specific character appears,
  taking case into account.
  Tip: If you can solve this without using a for-in loop, you can consider it a Tricky challenge.
  
 Sample input and output
 
 • The letter “a” appears twice in “The rain in Spain”.
 
 • The letter “i” appears four times in “Mississippi”.
 
 • The letter “i” appears three times in “Hacking with Swift”.
 

 [Next](@next)
*/

import Foundation

func challenge5(_ string: String, char: Character) -> Int {
    var count: Int = 0
    string.forEach() { character in
        if character == char {
            count += 1
        }
    }
    print("count : \(count)")
    return count
}
// 10% slower
func challenge5Functional(_ string: String, count: Character)  -> Int {
    let letterCount = string.reduce(0){ $1 == count ? $0 + 1 : $0 }
    print(letterCount)
    return letterCount
}

/*:
 #### NSCountedSet
 Now to how it works: a set is like an array, except each item can appear only once. If we used a Swift set in the below code, the set ensures each item appears only once.
 
 Now for the twist: NSCountedSet works similar to a set insofar as each object can appear only once, but it keeps track of how many times each item was added and removed.
 NSCountedSet has a count(for:) method that will report back that how many times an object was added.
 */

// a massive ten times slower than the original. Characters as input cant be used. has to be strings
func challenge5NS(_ string: String, count: String) -> Int {
    let array = string.map{String($0)}
    let counted = NSCountedSet(array: array)
    print(array)
    print(counted.count(for: count))
    return counted.count(for: count)
}
 
challenge5NS("sdkjhfgd", count: "s")

// slow but a possibility. you can calculate how many times a letter appears in a string by removing it, then comparing the lengths of the original and modified strings

func challenge5Lateral(_ string: String, count: String) -> Int {
    let modified = string.replacingOccurrences(of: count, with: "")
    return string.count - modified.count
}
challenge5Lateral("fsdfsdfsds", count: "s")



assert(challenge5("The rain in Spain", char: "a") == 2, "Challenge failed")
assert(challenge5("Mississippi", char: "i") == 4, "Challenge failed")
assert(challenge5("Hacking with Swift", char: "i") == 3, "Challenge failed")

assert(challenge5Functional("The rain in Spain", count: "a") == 2, "Challenge failed")
assert(challenge5Functional("Mississippi", count: "i") == 4, "Challenge failed")
assert(challenge5Functional("Hacking with Swift", count: "i") == 3, "Challenge failed")

/*:
 [Previous](@previous)

# Challenge 6: Remove duplicate letters from a string

### Difficulty: Easy
 Write a function that accepts a string as its input, and returns the same string just with
 duplicate letters removed.
 Tip: If you can solve this challenge without a for-in loop, you can consider it “tricky” rather than “easy”.
  
 Sample input and output
 
 • The string “wombat” should print “wombat”.
 
 • The string “hello” should print “helo”.
 
 • The string “Mississippi” should print “Misp”.
 

 [Next](@next)
*/
import Foundation

func challenge6(_ string: String) -> String {
    var newString = ""
    string.forEach(){ char in
        if !newString.contains(char){
        newString.append(char)
    //print(newString)
        }
    }
    return newString
}
//challenge6("missi")

// with NSOrdered sets

func challenge6Sets(_ string: String) -> String {
      //var newString = string.filter{ $0  }
      let array = string.map { String($0)}
  //    print(array)
      let set = NSOrderedSet(array: array)
    //  print(set)
      let result = Array(set) as! Array<String>
      //print(result)
      return result.joined()
    
}

// with dict but three times slower

func challenge6Functional(_ string: String) -> String {
    var used = [Character : Bool]()
    let result = string.filter {
        used.updateValue(true, forKey: $0) == nil
    }
    //print(result)
    return result
}


assert(challenge6("wombat") == "wombat", "Challenge failed")
assert(challenge6("helo") == "helo", "Challenge failed")
assert(challenge6("Mississippi") == "Misp", "Challenge failed")

assert(challenge6Functional("wombat") == "wombat", "Challenge faileled")
assert(challenge6Functional("helo") == "helo", "Challenge failed")
assert(challenge6Functional("Mississippi") == "Misp", "Challenge failed")

assert(challenge6Sets("wombat") == "wombat", "Challenge faileled")
assert(challenge6Sets("helo") == "helo", "Challenge failed")
assert(challenge6Sets("Mississippi") == "Misp", "Challenge failed")
