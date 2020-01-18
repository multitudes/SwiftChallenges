/*:
 [Previous](@previous)

# Challenge 6: Remove duplicate letters from a string

## Difficulty: Easy
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
