/*:
 [Previous](@previous)

# Challenge 7: Condense whitespace

## Difficulty: Easy
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
