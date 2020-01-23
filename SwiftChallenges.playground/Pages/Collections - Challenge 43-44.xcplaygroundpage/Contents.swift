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
    func printNodes() {
        var currentNode = start
        while let node = currentNode {
            print(node.value, terminator: " ")
            currentNode = node.next
        }
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
