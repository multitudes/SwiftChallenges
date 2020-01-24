/*:
 [Previous](@previous)

 # Challenge 48: Implement a deque data structure
 
 #### Difficulty: Tricky

Create a new data type that models a double-ended queue using generics, or deque. You should be able to push items to the front or back, pop them from the front or back, and get the number of items.
 Tip: It’s pronounced like “deck”.
 
 Sample input and output
 
 Once your data structure has been created, this code should compile and run cleanly:
 
var numbers = deque<Int>()
 numbers.pushBack(5) numbers.pushBack(8)
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

var str = "Hello, playground"


