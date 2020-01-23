/*:
 [Previous](@previous)

 # Challenge 37: Count the numbers
 
 #### Difficulty: Easy

 Write an extension for collections of integers that returns the number of times a specific digit
 appears in any of its numbers.
 
 #### Sample input and output
 
 • The code [5, 15, 55, 515].challenge37(count: "5") should return 6.
 
 • The code [5, 15, 55, 515].challenge37(count: "1") should return 2.
 
 • The code [55555].challenge37(count: "5") should return 5.
 
 • The code [55555].challenge37(count: "1") should return 0.
 
 #### Hints
 
 Hint #1: You’ll need to extend the Collection type with a specific constraint rather than a protocol constraint.
 
 Hint #2: If you convert each number to a string, you can loop over its characters.
 
 Hint #3: If you were functionally inclined, you could solve this challenge using reduce() and filter().
 
 [Next](@next)
*/

import Foundation

extension Collection where Iterator.Element == Int {
    func challenge37(count: Character) -> Int {
        var total = 0
        for item in self {
            // stringify
            let str = String(item)
            // loop over the letters
            for letter in str {
                if letter == count {
                    total += 1
                }
            }
        }
        return total
    }
    
    func challenge37b(count: Character) -> Int {
        return self.reduce(0) {
            $0 + String($1).filter { (char: Character) -> Bool in
            char == count }.count
            }
    }
}


[5, 15, 55, 515].challenge37(count: "5") // should return 6.

[5, 15, 55, 515].challenge37(count: "1") // should return 2.

[55555].challenge37(count: "5") //should return 5.

[55555].challenge37(count: "1") //should return 0.

[5, 15, 55, 515].challenge37b(count: "5") // should return 6.

[5, 15, 55, 515].challenge37b(count: "1") // should return 2.

[55555].challenge37b(count: "5") //should return 5.

[55555].challenge37b(count: "1") //should return 0.



