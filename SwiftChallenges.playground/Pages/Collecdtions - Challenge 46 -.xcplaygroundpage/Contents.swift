/*:
 [Previous](@previous)

 # Challenge 45: Recreate map()
 
 #### Difficulty: Tricky

Write an extension for all collections that reimplements the map() method.
 
 
 Sample input and output
 
 • The code [1, 2, 3].challenge46 { String($0) } should return [“1”, "2", "3"]
 
 • The code ["1", "2", "3"].challenge46 { Int($0)! } should return [1, 2, 3].
 
 #### Hints
 
 Hint #1: You’ll need to extend the Collection type.
 
 Hint #2: Your transformation function should accept a parameter of type Iterator.Element, but must return a generic parameter.
 
 Hint #3: You should accept transformation functions that throw, but you don’t want to handle any exceptions in your mapping method.
 
 Hint #4: Non-throwing functions are sub-types of throwing functions.
 
 Hint #5: You really ought to use rethrows to avoid irritating users who use non-throwing functions.
 
 [Next](@next)
*/

import Foundation



