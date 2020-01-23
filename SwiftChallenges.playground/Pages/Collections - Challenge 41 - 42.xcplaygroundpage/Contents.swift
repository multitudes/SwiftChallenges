/*:
 [Previous](@previous)

 # Challenge 41: Find the median
 
 #### Difficulty: Easy

 Write an extension to collections that accepts an array of Int and returns the median average,
 or nil if there are no values.
 Tip: The mean average is the sum of some numbers divided by how many there are. The median average is the middle of a sorted list. If there is no single middle value – e.g. if there are eight numbers - then the median is the mean of the two middle values.

 
 #### Sample input and output
 If your test array were created like this:

 • The code [1, 2, 3].challenge41() should return 2.
 
 • The code [1, 2, 9].challenge41() should return 2.
 
 • The code [1, 3, 5, 7, 9].challenge41() should return 5.
 
 • The code [1, 2, 3, 4].challenge41() should return 2.5.
 
 • The code [Int]().challenge41() should return nil.
 
 #### Hints
 
 Hint #1: You’ll need to extend Collection with a specific constraint.
 
 Hint #2: The method should return Double? because it might be a whole number, it might be a mean average of two numbers, or it might be nil if the collection is empty.
 
 Hint #3: If you divide an odd integer by two, Swift will round down.
 
 Hint #4: If you divide an even-numbered collection’s count by two, you’ll get the highest of the two values you need for your mean.
 
 Hint #5: Make life easy for yourself: sort the collection first.

 [Next](@next)
*/

import Foundation

var str = "Hello, playground"

extension Collection where Iterator.Element == Int {
    func challenge41() -> Double? {
        guard count != 0 else { return nil }
        let sorted = self.sorted()
        print(sorted)
        let median = count / 2
        print(median)
        
        if count % 2 == 0 {
            print(count)
            return Double(sorted[median] + sorted[median - 1]) / 2.0
        } else { return Double(sorted[median]) }
    }
    // this is the average
    func challenge41a() -> Double? {
        guard count != 0 else { return nil }
        return Double(Double(self.reduce(0, +)) / Double(count))
             //Double(self.average)
    }
}


[1, 2, 3].challenge41() //should return 2.
[1, 2, 9].challenge41() //should return 2.
[1, 3, 5, 7, 9].challenge41() //should return 5.
[1, 2, 3, 4].challenge41() //should return 2.5.
[Int]().challenge41() // should return nil.

[1, 2, 3].challenge41a() //should return 2.
[1, 2, 9].challenge41a() //should return 4.
[1, 3, 5, 7, 9].challenge41a() //should return 5.
[1, 2, 3, 4].challenge41a() //should return 2.5.
[Int]().challenge41a() // should return nil.


/*:
 [Previous](@previous)

 # Challenge 42: Recreate index(of:)
 
 #### Difficulty: Easy

 Write an extension for all collections that reimplements the index(of:) method.
 Tip: This is one of the easiest standard library methods to reimplement, so please give it an especially good try before reading any hints.

 
 #### Sample input and output

 • The code [1, 2, 3].challenge42(indexOf: 1) should return 0.

 • The code [1, 2, 3].challenge42(indexOf: 3) should return 2.

 • The code [1, 2, 3].challenge42(indexOf: 5) should return nil.
 
 #### Hints
 
 Hint #1: You will need to extend Collection using a constraint on the type of element it stores.
 
 Hint #2: Your return type should be Int? because the item might not exist in the collection.
 
 Hint #3: This would be a good time to use enumerated() to retrieve items and their index from a collection.
 
 [Next](@next)
*/

extension Collection where Iterator.Element : Equatable  {
    func challenge42(indexOf search: Iterator.Element) -> Int? {
        guard count != 0 else {
            return nil
        }
        for (index, number) in self.enumerated()  {
         //   print(number)
            if number == search { return index  }
        }
        return nil
    }
}


[1, 2, 3].challenge42(indexOf: 1) //should return 0.
[1, 2, 3].challenge42(indexOf: 3) //should return 2.
[1, 2, 3].challenge42(indexOf: 5) //should return nil.
