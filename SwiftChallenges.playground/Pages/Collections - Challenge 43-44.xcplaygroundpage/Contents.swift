/*:
 [Previous](@previous)

 # Challenge 43: Linked lists
 
 #### Difficulty: Easy

 Create a linked list of lowercase English alphabet letters, along with a method that traverses all
 nodes and prints their letters on a single line separated by spaces.
 
 Tip #1: This is several problems in one. First, create a linked list data structure, which itself is really two things. Second, use your linked list to create the alphabet. Third, write a method traverses all nodes and prints their letters.
 
 Tip #2: You should use a class for this. Yes, really.
 
 Tip #3: Once you complete your solution, keep a copy of the code – you’ll need it for future
 challenges!
 
 Sample input and output
 
 • The output of your code should be the English alphabet printed to the screen, i.e. “a b c d ... x y z”.
 

 [Next](@next)
*/
import Foundation

var str = "Hello, playground"

class Letter {
    var previous: Character?
    var next: Character?
    var current: Character
    
    init(current: Character) {
        self.current = current
    }
}

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
}

let alphabet = "abcdefghijklmnopqrstuvwxyz"

func challenge43(alphabet: String) {
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
    list.printNodes()
}

challenge43(alphabet: alphabet)

/*:
 [Previous](@previous)

 # Challenge 44: Linked list mid-point
 
 #### Difficulty: Easy

 Extend your linked list class with a new method that returns the node at the mid point of the
 linked list using no more than one loop.
 Tip: If the linked list contains an even number of items, returning the one before or the one after the center is acceptable.
 

 Sample input and output
 
 • If the linked list contains 1, 2, 3, 4, 5, your method should return 3.
 
 • If the linked list contains 1, 2, 3, 4, your method may return 2 or 3.
 
 • If the linked list contains the English alphabet, your method may return M or N.

 Hints
 Hint #1: It’s easy to solve this in two passes, but only fractionally harder to solve it in one. Hint #2: If you use fast enumeration – for i in items – you move over one item at a
 time. Can you think of a way of moving over more than one item?
 Hint #3: Once you pull out two items at the same time, you can make them move at different speeds through the list.
 Hint #4: If you move pointer A through the list one item at a time, and pointer B through the list two items at a time, by the time pointer B reaches the end where will pointer A be?

 [Next](@next)
*/
// added above in the linked list class
func challenge44(linkedlist: String) {
    let list = LinkedList<Character>()
    var previousNode: LinkedListNode<Character>? = nil
    
    for letter in linkedlist {
        
        let node = LinkedListNode(value: letter)
        
        if let predecessor = previousNode {
            predecessor.next = node
        } else {
            list.start = node
        }
        
        previousNode = node
    }
    list.midPoint()
}
challenge44(linkedlist: alphabet) //your method may return M or N.

var numbers = "12345" // your method should return 3.
challenge44(linkedlist: numbers)

numbers = "1234" //your method may return 2 or 3.
challenge44(linkedlist: numbers)

//pauls

func challenge44Paul(linkedlist: String) {
    let list = LinkedList<Character>()
     var previousNode: LinkedListNode<Character>? = nil
     
     for letter in linkedlist {
         
         let node = LinkedListNode(value: letter)
         
         if let predecessor = previousNode {
             predecessor.next = node
         } else {
             list.start = node
         }
         
         previousNode = node
     }
    print(list.centerNode?.value ?? "")
}

challenge44Paul(linkedlist: numbers)
numbers = "1234" //your method may return 2 or 3.
challenge44Paul(linkedlist: numbers)

challenge44Paul(linkedlist: alphabet)


/*:
 [Previous](@previous)

 # Challenge 45: Traversing the tree // to do after 54!
  
 #### Difficulty: Easy

 **Note: this challenge cannot be attempted until you have first completed challenge 54.**
 
 Write a new method for your binary search tree that traverses the tree in order, running a closure on each node.
 Tip: Traversing a node in order means visiting its left value, then visiting its own value, then visiting its right value.

Assuming a binary tree created from the array [2, 1, 3]:
 
The code tree.root?.traverse { print($0.key) } should print 1, 2, 3.

The code var sum = 0; tree.root?.traverse { sum += $0.key }; print(sum) should print 6.

The code var values = [Int](); tree.root?.traverse  { values.append($0.key) }; print(values.count) should print 3.

 #### Hints
 
 Hint #1: Your entire function can be just three lines of code. Yes, it really is that easy – hurray for recursion!

 Hint #2: You can write this method for the binary tree class or for its nodes; it really doesn’t matter. I chose to write it for the nodes so that I can print partial trees.

 Hint #3: Make sure it accepts a closure parameter that itself accepts one parameter (your Node<T> equivalent) and returns void.

 Hint #4: Remember the left and/or right node may not exist.

 [Next](@next)
*/
