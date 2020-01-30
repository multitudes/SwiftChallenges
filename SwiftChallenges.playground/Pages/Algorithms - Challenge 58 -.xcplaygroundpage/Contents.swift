/*:
 [Previous](@previous)

 # Challenge 58: Balanced brackets
 
 #### Difficulty: Easy

 Write a function that accepts a string containing the characters (, [, {, <, >, }, ], and ) in any arrangement and frequency. It should return true if the brackets are opened and closed in the correct order, and if all brackets are closed. Any other input should false.

 Sample input and output

 • The string “()” should return true.

 • The string “([])” should return true.

 • The string “([])(<{}>)” should return true.

 • The string “([]{}<[{}]>)” should return true.

 • The string “” should return true.

 • The string “}{” should return false.

 • The string “([)]” should return false.

 • The string “([)” should return false.

 • The string “([” should return false.

 • The string “[<<<{}>>]” should return false.

 • The string “hello” should return false.

 Hints

 Hint #1: You should start by making the most simple check: does the string have only the eight different characters that are allowed?

 Hint #2: Each type of opening bracket has only one matching opening bracket, so you should store that data somehow – a dictionary would
 seem sensible.
 
 Hint #3: Every bracket need to be closed at some point, but not necessarily immediately – it might be closed many characters later, for example. So, you need to push it onto a stack, then wait.
 
 Hint #4: As you loop over each character in the string, it’s either an opening bracket or a closing bracket. If it’s an opening one it can go on your stack; if it’s a closing one, then it should be the matching pair of whatever is on the end of your bracket stack.
 
 Hint #5: If the function ends with anything left in the bracket stack it means there was one bracket that was not closed – a failure.
 
 [Next](@next)
*/
import Foundation

//Solution
//This challenge requires a basic understanding of stacks: last in, first out (LIFO) collections that push items on to a data store then pop them off as needed. As each opening bracket comes in, we can push it onto the stack so that when it comes to reading back items the most recently opened bracket is the one we read first.
// Swift doesn’t have a native stack data type, but we can get the same behavior just by using an array and using its append() and popLast() methods.

func challenge58(input: String) -> Bool {
    
    //ensuring that only brackets appear in the string. This can be done by creating a CharacterSet from the list of good letters (([{<>}])), then inverting the set and ensuring the input string doesn’t match:
    let validBrackets = "([{<>}])"
    let validCharacterSet = CharacterSet(charactersIn: validBrackets).inverted
    print(input.rangeOfCharacter(from: validCharacterSet))
    //Finds and returns the range in the String of the first character from a given character set
    // if a bracket then there is no matching range in the character set because inverted
    guard input.rangeOfCharacter(from: validCharacterSet) == nil else {print("no brackets"); return false }

    if input == "" {print("empty string"); return true }

    //  we need to declare the relationships between opening and closing brackets, so Swift knows which closing bracket goes with each opening bracket. The easiest way to do that is with a dictionary, where the opening bracket is the dictionary key and the closing bracket is the value

     let matchingBrackets: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">"]
    //Using this approach, when we meet a character like “)” we can read the last used bracket from our stack, and check that matchingBrackets[lastUsedBracket] matches “)”. If not, the brackets were closed out of order and the string is invalid.
    
    // Speaking of the stack it is an array of characters of course
    var usedBrackets = [Character]()
    
    for bracket in input {
        //print(bracket)
        if matchingBrackets.keys.contains(bracket) {
            // it is a opening one
            usedBrackets.append(bracket)
            print("append \(bracket)")
        } else {
            // it has to be a closing bracket if it is not the opening one
            // I pop the previous one which is an optional so need to use if let
            if let previousBracket = usedBrackets.popLast(){
            print("pop \(previousBracket)")
                if matchingBrackets[previousBracket] != bracket {
                // if they don't match, this is a bad string
                return false
                }
            } else {
                // something is wrong optional is nil..
                return false
            }
        }
    }
    return usedBrackets.count == 0
}

challenge58(input: "()") // should return true.
challenge58(input: "([])") // should return true.
challenge58(input: "([])(<{}>)") // should return true.
challenge58(input: "([]{}<[{}]>)") // should return true.
challenge58(input: "")          //should return true.
challenge58(input: "}{")        // should return false.
challenge58(input: "([)]")      // should return false.
challenge58(input: "([)")       // should return false.
challenge58(input: "([")        // should return false.
challenge58(input: "[<<<{}>>]")         // should return false.
challenge58(input: "hello")             // should return false.


/*:
 [Previous](@previous)

 # Challenge 59: Quicksorts
 
 #### Difficulty: Tricky

 Write a function that accepts a string containing the characters (, [, {, <, >, }, ], and ) in any arrangement and frequency. It should return true if the brackets are opened and closed in the correct order, and if all brackets are closed. Any other input should false.

 Sample input and output

 • The string “()” should return true.

 • The string “([])” should return true.

 • The string “([])(<{}>)” should return true.

 • The string “([]{}<[{}]>)” should return true.

 • The string “” should return true.

 • The string “}{” should return false.

 • The string “([)]” should return false.

 • The string “([)” should return false.

 • The string “([” should return false.

 • The string “[<<<{}>>]” should return false.

 • The string “hello” should return false.

 Hints

 Hint #1: You should start by making the most simple check: does the string have only the eight different characters that are allowed?

 Hint #2: Each type of opening bracket has only one matching opening bracket, so you should store that data somehow – a dictionary would
 seem sensible.
 
 Hint #3: Every bracket need to be closed at some point, but not necessarily immediately – it might be closed many characters later, for example. So, you need to push it onto a stack, then wait.
 
 Hint #4: As you loop over each character in the string, it’s either an opening bracket or a closing bracket. If it’s an opening one it can go on your stack; if it’s a closing one, then it should be the matching pair of whatever is on the end of your bracket stack.
 
 Hint #5: If the function ends with anything left in the bracket stack it means there was one bracket that was not closed – a failure.
 
 [Next](@next)
*/
