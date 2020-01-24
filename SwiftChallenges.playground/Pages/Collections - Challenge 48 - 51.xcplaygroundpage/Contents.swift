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


/*:
 [Previous](@previous)

 # Challenge 50: Count the largest range
 
 #### Difficulty: Tricky

Write a function that accepts an array of positive and negative numbers and returns a closed range containing the position of the contiguous positive numbers that sum to the highest value, or nil if nothing were found.
 
 Sample input and output
 
 • The array [0, 1, 1, -1, 2, 3, 1] should return 4...6 because the highest sum of contiguous positive numbers is 2 + 3 + 1, which lie at positions 4, 5, and 6 in the array.
 
 • The array [10, 20, 30, -10, -20, 10, 20] should return 0...2.
 
 • The array [1, -1, 2, -1] should return 2...2.
 
 • The array [2, 0, 2, 0, 2] should return 0...0.
 
 • The array [Int]() should return nil.


 Hints

 Hint #1: This challenge is best solved using a little trial and error – start by writing tests to ensure your solution is good as you work.
 
 Hint #2: Your return type should be CountableClosedRange<Int>? because there might not be any ranges of positive numbers.
 
 Hint #3: This would be a good time to use enumerated() to retrieve items and their index from a collection.
 
 Hint #4: There are two very different cases: if a number is greater than 0, and “everything else”. The index you return needs to be different, because a positive integer you find might be the last one in the array.
 
 [Next](@next)
*/


func challenge50(_ input: [Int]) -> CountableClosedRange<Int>? {
    //return value is nil by default
    var bestRange: CountableClosedRange<Int>? = nil
    var bestSum = 0
    // track the current sequence
    var currentStart: Int? = nil
    var currentSum = 0
    
    for (index, number) in input.enumerated() {
        if number > 0 {
            // if we do not have a start for the current range , set one
            currentStart = currentStart ?? index
            currentSum += number
            if currentSum > bestSum {
                // update
                bestRange = currentStart! ... index
                bestSum = currentSum
            }
            } else {
            // reset the current range
            currentSum = 0
            currentStart = nil
        }
    }
    return bestRange
}

challenge50([0, 1, 1, -1, 2, 3, 1]) // should return 4...6 because the highest sum of contiguous positive numbers is 2 + 3 + 1, lie at positions 4, 5, and 6 in the array.
challenge50([10, 20, 30, -10, -20, 10, 20]) // should return 0...2.
challenge50([1, -1, 2, -1]) //should return 2...2.
challenge50([2, 0, 2, 0, 2]) // should return 0...0.
challenge50([Int]()) // should return nil.

/*:
 [Previous](@previous)

 # Challenge 51: Reversing linked lists
 
 #### Difficulty: Tricky

Expand your code from challenge 43 so that it has a reversed() method that returns a copy
of itself in reverse.
Tip: Don’t cheat! It is not a solution to this problem just to reverse the alphabet letters before you create your linked list. Create the linked list alphabetically, then write code to reverse it.

 Sample input and output
 
 • When you call reversed() on your alphabet list, running printNodes() on the return value should print the English alphabet printed to the screen in reverse, i.e. “z y x ... d b c a”.



 Hints

 Hint #1: Most of the work is just producing a copy of the linked list. Hint #2: Having to work on a copy makes this a little more interesting.
 
 Hint #3: You could create two methods: one for copying, and one for reversing a copy in place. If you do this, please think carefully about Swift’s naming conventions!
 
 Hint #4: You need to create a newNext variable that starts as nil. Then traverse the full list, pull out its next value, then change the current node’s next property to be newNext. You can then continue on to whatever node was in next, and repeat until the end of the list is reached.
 
 [Next](@next)
*/

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var start: LinkedListNode<T>?
    
    // pauls mid point
    var centerNode: LinkedListNode<T>? {
        var slow = start
        var fast = start
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    func printNodes() {
        var currentNode = start
        while let node = currentNode {
            print(node.value, terminator: " ")
            currentNode = node.next
        }
    }
    func midPoint() {
        var currentNodeA = start
        var currentNodeB = start
        while let nodeA = currentNodeA, let nodeB = currentNodeB {
             currentNodeB = nodeB.next
            guard let secondNode = currentNodeB?.next else { break}
            currentNodeA = nodeA.next
            currentNodeB = secondNode
        }
        guard let node = currentNodeA else { return }
        print("mid point is : \(node.value)")
     }
    func reversed() ->  LinkedList<T> {
        // create a copy
        let copy = LinkedList<T>()
        if let startNode = start {
            var previousCopyNode = LinkedListNode(value: startNode.value)
            var currentNode = start?.next
            // loop over my orig list copying the items
            while let node = currentNode {
                let copyNode = LinkedListNode(value: node.value)
                // make it point to our previous node
                copyNode.next = previousCopyNode
                // make it the previous one
                previousCopyNode = copyNode
                currentNode = currentNode?.next
                
            }
            // we are at the end of the orig list, our start!
            copy.start = previousCopyNode
        }
        return copy
    }
    //just create our own copy() method
    func copy() -> LinkedList<T> {
        let copy = LinkedList<T>()
        if let startNode = start {
            copy.start = LinkedListNode(value: startNode.value)
            var previousCopyNode = copy.start
            var currentNode = start?.next
            while let node = currentNode {
                let copyNode = LinkedListNode(value: node.value)
                previousCopyNode?.next = copyNode
                previousCopyNode = copyNode
                currentNode = currentNode?.next
            }
        }
        return copy
    }
    // create our reversed() method that reverses a linked list in place.
    func reverse() {
        var currentNode = start
        var newNext: LinkedListNode<T>? = nil
        while let node = currentNode {
            let next = node.next
            node.next = newNext
            newNext = node;
            currentNode = next
        }
        start = newNext
    }
    func reversed2() -> LinkedList<T> {
        let copy = self.copy()
        copy.reverse()
        return copy
    }
}

let alphabet = "abcdefghijklmnopqrstuvwxyz"

func challenge51(alphabet: String) {
    let list = LinkedList<Character>()
    var previousNode: LinkedListNode<Character>? = nil
    
    for letter in alphabet {
        
        let node = LinkedListNode(value: letter)
        
        if let predecessor = previousNode {
            predecessor.next = node
        } else {
            list.start = node
        }
        
        previousNode = node
    }
    list.reversed().printNodes()
    //list.reversed2().printNodes()
}
 challenge51(alphabet: alphabet)


