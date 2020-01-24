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

// the use of “throws” and “rethrows”. This is covered in detail in Pro Swift: marking the parameter with throws means only that it might throw, not that it will throw, and marking the whole thing as rethrows means it need be used with try/catch only when its parameter really does throw.
extension Collection {
    // generic method accepting a closure and returning a new type
    func challenge46<T>(_ transform: (Iterator.Element) throws -> T) rethrows -> [T]     {
        // create return array
        var returnValue = [T]()
        // loop over our items trying the transformation
        for item in self {
            returnValue.append(try transform(item))
        }
        return returnValue
    }
}

let a = [1, 2, 3].challenge46 { String($0) }
print(a)
let b = ["1", "2", "3"].challenge46 { Int($0)! } // should return [1, 2, 3].
print(b)

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
