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


