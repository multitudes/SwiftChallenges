/*:
 [Previous](@previous)

# Challenge 7: Condense whitespace

### Difficulty: Easy
 Write a function that returns a string with any consecutive spaces replaced with a single space.
 Sample input and output
 I’ve marked spaces using “[space]” below for visual purposes:
 • The string “a[space][space][space]b[space][space][space]c” should return “a[space]b[space]c”.
 • The string “[space][space][space][space]a” should return “[space]a”.
 • The string “abc” should return “abc”.
 [Next](@next)
*/


import Foundation


func challenge7(_ string: String) -> String {
    //var seenSpace = false
    var previous = Character("")
    var seen = Array<Character>()
    for character in string {
        if character == previous && character == " " {
            continue
        }
        seen.append(character)
        previous = character
    }
    print(String(seen))
    return String(seen)
}

challenge7("s    ss  s s")

func challenge7a(_ string: String) -> String {
    var seenSpace = false
    var returnValue = ""
    
    for character in string {
        if character == " " {
            if seenSpace { continue }
                seenSpace = true
            } else {
                seenSpace = false
            }
            returnValue.append(character)
            }
    return returnValue
}
               
challenge7a("s       a a")


//Running regular expressions isn’t cheap, so that code runs about 50% the speed of the manual solution,
func challenge7Regex(_ string: String) -> String {
    return string.replacingOccurrences(of: "\\s+", with: " ",  options: .regularExpression)
}
challenge7Regex("s       a a")




assert(challenge7("a      c") == "a c", "Challenge failed")
assert(challenge7("    a") == " a", "Challenge failed")
assert(challenge7("abc") == "abc", "Challenge failed")

assert(challenge7a("a      c") == "a c", "Challenge failed")
assert(challenge7a("    a") == " a", "Challenge failed")
assert(challenge7a("abc") == "abc", "Challenge failed")

assert(challenge7Regex("a      c") == "a c", "Challenge failed")
assert(challenge7Regex("    a") == " a", "Challenge failed")
assert(challenge7Regex("abc") == "abc", "Challenge failed")

/*:
 [Previous](@previous)

# Challenge 8: String is rotated

### Difficulty: Tricky

Write a function that accepts two strings, and returns true if one string is rotation of the other, taking letter case into account.
 
Tip: A string rotation is when you take a string, remove some letters from its end, then append them to the front. For example, “swift” rotated by two characters would be “ftswi”.

 Sample input and output
 
• The string “abcde” and “eabcd” should return true.
 
• The string “abcde” and “cdeab” should return true.
 
• The string “abcde” and “abced” should return false; this is not a string rotation.
 
• The string “abc” and “a” should return false; this is not a string rotation.
 

 [Next](@next)
*/
import Foundation

func challenge8(_ string1: String, with string2: String ) -> Bool {
    if string1.count != string2.count { return false }
    var tempArray  = Array(string1)
    for _ in 0..<string1.count {
        let a = tempArray.removeFirst()
        print(a)
        tempArray.append(a)
        print(tempArray)
        if String(tempArray) == string2 {return true}
    }
    return false
}

challenge8("abc", with: "cab")


// Hint #3: If you write a string twice, it must encapsulate all possible rotations, e.g. “catcat” contains “cat”, “tca”, and “atc”.


func challenge8a(_ string1: String, with string2: String ) -> Bool {
    guard string1.count == string2.count else { return false }
    let combined = string1 + string1
    print(combined)
    return combined.contains(string2)
}

challenge8a("abc", with: "cab")

////
assert(challenge8("abcde",with: "abcde") == true, "Challenge failed")
assert(challenge8("abcde",with: "cdeab") == true, "Challenge failed")
assert(challenge8("abcde",with: "abced") == false, "Challenge failed")
assert(challenge8("abc", with: "a") == false, "Challenge failed")

assert(challenge8a("abcde",with: "abcde") == true, "Challenge failed")
assert(challenge8a("abcde",with: "cdeab") == true, "Challenge failed")
assert(challenge8a("abcde",with: "abced") == false, "Challenge failed")
assert(challenge8a("abc", with: "a") == false, "Challenge failed")
