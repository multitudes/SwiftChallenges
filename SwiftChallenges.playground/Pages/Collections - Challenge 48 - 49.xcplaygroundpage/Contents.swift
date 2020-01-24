/*:
 [Previous](@previous)

 # Challenge 48: Implement a deque data structure
 
 #### Difficulty: Tricky

Create a new data type that models a double-ended queue using generics, or deque. You should be able to push items to the front or back, pop them from the front or back, and get the number of items.
 Tip: It’s pronounced like “deck”.
 
 Sample input and output
 
 Once your data structure has been created, this code should compile and run cleanly:
 
var numbers = deque<Int>()
 numbers.pushBack(5)
 numbers.pushBack(8)
 numbers.pushBack(3)
 assert(numbers.count == 3)
 assert(numbers.popFront()! == 5)
 assert(numbers.popBack()! == 3)
 assert(numbers.popFront()! == 8)
 assert(numbers.popBack() == nil)

 Hints
 Hint #1: Use an internal array for your data.
 
 Hint #2: If you used a class for this, expect to be questioned carefully as to why you didn’t choose a struct.
 
 Hint #3: You’ll need to declare your whole data type as being generic, e.g. struct deque<T> {.
 
 Hint #4: The popBack() and popFront() method should return optionals, because the deque might be empty.
 
 Hint #5: You’ll need to mark your methods as mutating.
 
 Hint #6: Make sure count is a property rather than a method. Something like var count: Int { return array.count } ought to do it.
 
 [Next](@next)
*/

import Foundation

struct deque<T> {
    var array = [T]()
    var count: Int {
        return array.count
    }
    mutating func pushBack(_ obj: T){
        array.append(obj)
    }
    mutating func pushfront(_ obj: T){
        array.insert(obj, at: 0)
    }
    mutating func popBack() -> T? {
        return array.popLast()
    }
    mutating func popFront() -> T? {
        if array.isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
}
var numbers = deque<Int>()
numbers.pushBack(5)
numbers.pushBack(8)
numbers.pushBack(3)
print(numbers)
assert(numbers.count == 3)
assert(numbers.popFront()! == 5)
assert(numbers.popBack()! == 3)
assert(numbers.popFront()! == 8)
assert(numbers.popBack() == nil)

/*:
 [Previous](@previous)

 # Challenge 49: Sum the even repeats
 
 #### Difficulty: Tricky

Write a function that accepts a variadic array of integers and return the sum of all numbers that appear an even number of times.

 Sample input and output
 
 • The code challenge49(1, 2, 2, 3, 3, 4) should return 5, because the numbers 2 and 3 appear twice each.

 • The code challenge49(5, 5, 5, 12, 12) should return 12, because that’s the only number that appears an even number of times.

 • The code challenge49(1, 1, 2, 2, 3, 3, 4, 4)` should return 10.

 Hints

 Hint #1: This is a perfect use for NSCountedSet.

 Hint #2: But: NSCountedSet doesn’t use generics, so you’ll need to typecast somehow.  Expect to be judged on your method of typecasting!
 
 Hint #3: You’ll need to use modulus to find numbers that are repeated an even number of times.
 
 Hint #4: You’ll need to declare your parameter as numbers: Int....

 
 [Next](@next)
*/


// the cost of bridging between Any and Int is so small, taking the for case let approach ends up being almost 50% faster – and removes the ugly as! typecast.

func challenge49(numbers: Int...) -> Int {
    let counted = NSCountedSet(array: numbers)
    print(counted)
    var sum = 0
    
    for case let item as Int in counted {
        if counted.count(for: item) % 2 == 0 {
            sum += item
        }
    }
    return sum
}

challenge49(numbers: 1, 2, 2, 3, 3, 4) //should return 5
challenge49(numbers: 5, 5, 5, 12, 12) //should return 12,
challenge49(numbers: 1, 1, 2, 2, 3, 3, 4, 4) // should return 10.

//And here’s the slower solution that converts the counted set into an integer array before the loop:
func challenge49b(numbers: Int...) -> Int {
    let counted = NSCountedSet(array: numbers)
    let array = counted.allObjects as! [Int]
    var sum = 0
    for item in array {
        if counted.count(for: item) % 2 == 0 {
            sum += item
        }
    }
    return sum
}

challenge49b(numbers: 1, 2, 2, 3, 3, 4) //should return 5
challenge49b(numbers: 5, 5, 5, 12, 12) //should return 12,
challenge49b(numbers: 1, 1, 2, 2, 3, 3, 4, 4) // should return 10.

