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


/*:
 [Previous](@previous)

 # Challenge 38: Find N smallest
 
 #### Difficulty: Easy

 Write an extension for all collections that returns the N smallest elements as an array, sorted
 smallest first, where N is an integer parameter.
 
 #### Sample input and output
 
 • The code [1, 2, 3, 4].challenge38(count: 3) should return [1, 2, 3].
 • The code ["q", "f", "k"].challenge38(count: 10) should return [“f”,
 “k”, “q”].
 • The code [256, 16].challenge38(count: 3) should return [16, 256].
 • The code [String]().challenge38(count: 3) should return an empty
 array.
 
 #### Hints
 
 Hint #1: You’ll need to extend the Collection type with a constraint.
 Hint #2: Finding the smallest of any value requires using the < operator, which is guaranteed
 to exist when something conforms to Comparable.
 Hint #3: The collection might be contain fewer than N items.
 Hint #4: The solution is made more interesting by the requirement to return a variable number of results.
 Hint #5: If you want to avoid complexity, use sorted().
 
 [Next](@next)
*/


extension Collection where Iterator.Element: Comparable {
    func challenge38(count: Int) -> [Iterator.Element] {
        let sorted = self.sorted()
        return Array(sorted.prefix(count))
    }
}


[1, 2, 3, 4].challenge38(count: 3) //should return [1, 2, 3]
["q", "f", "k"].challenge38(count: 10) // should return [“f”,“k”, “q”].
[256, 16].challenge38(count: 3) // should return [16, 256].
[String]().challenge38(count: 3) // should return an empty array.


/*:
 [Previous](@previous)

 # Challenge 39: Sort a string array by length
 
 #### Difficulty: Easy

 Extend collections with a function that returns an array of strings sorted by their lengths,
 longest first.
 
 #### Sample input and output
 
 • The code ["a", "abc", "ab"].challenge39() should return ["abc", "ab", "a"].
 • The code ["paul", "taylor", "adele"].challenge39() should return ["taylor", "adele", "paul"].
 • The code [String]().challenge39() should return [].

 
 #### Hints
 
 Hint #1: You’ll need to extend the Collection type with a specific constraint rather than a protocol constraint.
 Hint #2: You should use the built-in sorted() method.
 Hint #3: You can provide a custom closure to sorted() to affect how it works.
 
 [Next](@next)
*/
