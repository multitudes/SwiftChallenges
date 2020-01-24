/*:
 [Previous](@previous)

 # Challenge 52: Sum an array of numbers
 
 #### Difficulty: Taxing

Write one function that sums an array of numbers. The array might contain all integers, all
doubles, or all floats.
Tip: If you think this challenge is easy, you’re either a hardened Swift pro or you’ve underestimated the problem.
 
 Sample input and output
 
 • The code challenge52(numbers: [1, 2, 3]) should return 6.
 
 • The code challenge52(numbers: [1.0, 2.0, 3.0]) should return 6.0.
 
 • The code challenge52(numbers: Array<Float>([1.0, 2.0, 3.0])) should return 6.0.
 
 Hints

 
 [Next](@next)
*/
import Foundation

protocol Numeric {
    init()
    static func +(lhs: Self, rhs: Self) -> Self
}

extension Int: Numeric {}
extension Double: Numeric {}
extension Float: Numeric {}

func challenge52<T: Numeric>(numbers: [T]) -> T {
    var total = T()
    
    for number in numbers {
        total = total + number
    }
    return total
}

challenge52(numbers: [1, 2, 3])                     // should return 6.
challenge52(numbers: [1.0, 2.0, 3.0])               // should return 6.0.
challenge52(numbers: Array<Float>([1.0, 2.0, 3.0])) // should return 6.0.

//Alternatively you can make it a functional one-liner using reduce():
func challenge52a<T: Numeric>(numbers: [T]) -> T {
    return numbers.reduce(T(), + )
}
challenge52a(numbers: [1, 2, 3])                     // should return 6.
challenge52a(numbers: [1.0, 2.0, 3.0])               // should return 6.0.
challenge52a(numbers: Array<Float>([1.0, 2.0, 3.0])) // should return 6.0.

//Apple’s Accelerate framework. This is a massive library of optimized mathematics routines that is incredibly fast at doing selected tasks.it works on floats and doubles but not integers
import Accelerate

func challenge52c(numbers: [Double]) -> Double {
    var result: Double = 0.0
    vDSP_sveD(numbers, 1, &result, vDSP_Length(numbers.count))
    return result
}
challenge52c(numbers: [1, 2, 3])                     // should return 6.
challenge52c(numbers: [1.0, 2.0, 3.0])               // should return 6.0.


/*:
 [Previous](@previous)

 # Challenge 53: Linked lists with a loop
 
 ## This is a challenge that is easy if you took the right courses at university, but an exercise in yak shaving if you didn’t. It’s also an extremely common interview question, so it’s one you should definitely prepare if you’re serious.
 
 #### Difficulty: Taxing

Someone used the linked list you made previously, but they accidentally made one of the items link back to an earlier part of the list. As a result, the list can’t be traversed properly because it loops infinitely.
Your job is to write a function that accepts your linked list as its parameter, and returns the node at the start of the loop, i.e. the one that is linked back to.
pro or you’ve underestimated the problem.
 
 Sample input and output
 You can simulate a looped link list with this code:
 ```
 var list = LinkedList<UInt32>()
 var previousNode: LinkedListNode<UInt32>? = nil var linkBackNode: LinkedListNode<UInt32>? = nil var linkBackPoint = Int(arc4random_uniform(1000))
 for i in 1...1000 {
 let node = LinkedListNode(value: arc4random())
 if i == linkBackPoint { linkBackNode = node }
 if let predecessor = previousNode { predecessor.next = node
 } else {
 list.start = node
 }
 previousNode = node }
 previousNode?.next = linkBackNode
 ```

 You will need to use whatever LinkedList and LinkedListNode structures you created in the previous challenge.
 When your code has finished, your findLoopStart() should return the same node contained in the linkBackNode variable.

 Hints
 
 Hint #1: There are two ways to solve this: using a set or using mathematics. You could also use an array, but only if you had no regard at all for performance.
 
 Hint #2: If you take the set approach you will need to conform to Hashable, which in turn implies Equatable.
 
 Hint #3: To conform to Hashable you must be able to give each of your linked list nodes a unique hashValue integer. You could store this as a property in your linked list, and increment it by 1 every time a `getUniqueHashValue() method is called.
 
 Hint #4: To conform to Equatable you will need to implement static func == on your linked list node. This could be as simple as returning true if the two hash values are the same.
 
 Hint #5: You can then loop over the nodes in your list, checking whether they are in a seen set. If a node isn’t in the set, add it; if it is in the set, you have your loop point so return it. If you reach the end of your list it means you didn’t have a loop, so return nil.
 
 Hint #6: You can also solve this problem with pure mathematics, which is both significantly faster and more memory efficient. If you ever learned to do tortoise and hare loop detection, now is your chance to feel smug!
 
 Hint #7: Your solution to challenge 44 provides the starting point for the mathematical solution here.
 
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
    func findLoopStartB() -> LinkedListNode<T>? {
        var slow = start
        var fast = start
        // go through the list until we find the end
        while fast != nil && fast?.next != nil {
            // slow moves one fast moves two
            slow = slow?.next
            fast = fast?.next?.next
            
            //if the two meet we found the loop
            if slow === fast {
                break
            }
        }
        // if fast is nil then we made it to the end of the loop
        guard fast != nil || fast?.next != nil else {
            return nil
        }
        // if we are still here we know for sure there is a loop
        slow = start
        
        // loop for the next match
        while slow! !== fast {
            // move slow and fast at the same speed
            slow = slow?.next
            fast = fast?.next
        }
        //slow and fast now point to the same now, so return either one of them
        print(slow?.value ?? 0)
        return slow
    }
}

var list = LinkedList<UInt32>()
var previousNode: LinkedListNode<UInt32>? = nil
var linkBackNode: LinkedListNode<UInt32>? = nil
var linkBackPoint = Int(arc4random_uniform(1000))
print(linkBackPoint)
for i in 1...1000 {
    let node = LinkedListNode(value: arc4random())
    //print(node.value)
    if i == linkBackPoint { linkBackNode = node }
    if let predecessor = previousNode {
        predecessor.next = node
    } else {
        list.start = node
    }
    previousNode = node
}
previousNode?.next = linkBackNode

// shaving the yak!
// for another time!

    let a = list.findLoopStartB()
//print(a.value)

/*:
 [Previous](@previous)

 # Challenge 54: Binary search trees
 
 #### Difficulty: Taxing

Create a binary search tree data structure that can be initialized from an unordered array of
comparable values, then write a method that returns whether the tree is balanced.

 Tip #1: There is more than one description of a balanced binary tree. For the purpose of this challenge, a binary tree is considered balanced when the height of both subtrees for every node differs by no more than 1.

 Tip #2: Once you complete this challenge, keep your code around because you’ll need it in the next one.
 
 Sample input and output
 
 The following values should create balanced trees:
 • [2, 1, 3]
 
 • [5, 1, 7, 6, 2, 1, 9]

 • [5, 1, 7, 6, 2, 1, 9, 1]

 • [5, 1, 7, 6, 2, 1, 9, 1, 3]

 • [50, 25, 100, 26, 101, 24, 99]

 • ["k", "t", "d", "a", "z", "m", "f"]

 • [1]

 • [Character]()

 The following values should not create balanced trees:

 • [1, 2, 3, 4, 5]

 • [10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15]

 • ["f", "d", "c", "e", "a", "b"]

 Hints

 Hint #1: You need to create a binary search tree rather than a plain binary tree. This means inserting nodes into the tree based on whether they are less than or equal (left) or greater than (right) their parent.
 
 Hint #2: You should make your data types use a generic value that conforms to Comparable.
 
 Hint #3: Each nodes should have a value, plus left and right optional nodes.
 
 Hint #4: To find the correct place for each array item, start at the top of your tree then keep moving left or right until you find nil – that’s your place.
 Hint #5: You might find it useful to make your binary tree type conform to CustomStringConvertible so you can add a custom var description: String that prints the contents of your tree.
 Hint #6: Checking a binary tree is balanced can be done by recursively comparing the minimum depth of both sides of a node against the maximum depth of both sides of a node. The tree can be considered balanced if the two values differ by no more than 1.

 
 [Next](@next)
*/

//we can define a binary tree node as a generic class that stores a key, as well as left and right values. In code, it looks like this:

class Node<T> {
    var key: T
    var left: Node<T>?
    var right: Node<T>?
    init(key: T) {
        self.key = key
    }
}
//That class will be used to hold one node somewhere in the tree, but we can create another class that wraps up the whole tree:

class BinarySearchTree<T: Comparable> : CustomStringConvertible {
    var root : Node<T>?
    init(array: [T]) {
        for item in array {
            print("item in array: \(item)")
            // this will be set to true when we've created a node from this item
            var placed = false
            // first pass root is nil, will be set below to the first element of the array then
            if let rootNode = root {
                // so this is the second pass and compare the items
                print("rootNode.key : \(rootNode.key)")
                // we have a root node, so make it our tracker
                var tracker = rootNode
                // at beginning for ex comparing the second item to the first (the root)
                while placed == false {
                    // if we're placing an item that comes before our tracker
                    if item <= tracker.key {
                        // if we don't already have a left node
                        if tracker.left == nil {
                            // make this item our left node
                            tracker.left = Node(key: item)
                            // mark it as placed and exit the loop
                            placed = true
                        }
                        // we already have a left node; make that the tracker so we can compare against it. and loop again until placed is true
                        tracker = tracker.left!
                    } else {
                        // this item is greater than our tracker, so it needs to sit on its right
                        // if we don't already have a right node
                        if tracker.right == nil {
                            // make this item our right node
                            tracker.right = Node(key: item)
                            // mark it as placed - exit the while
                            placed = true
                        }
                        // we already have a right node; make that the tracker so we can compare against it.
                        // and keep looping until placed is true
                        tracker = tracker.right!
                    }
                }
            } else {
                //this is at the first time when root is still nil
                root = Node(key: item)
                print("root is \(item)")
            }
        }
    }
    func isBalanced() -> Bool {
        func minDepth(from node: Node<T>?) -> Int {
            guard let node = node else { return 0 }
            let returnValue = 1 + min(minDepth(from: node.left), minDepth(from: node.right))
            print("Got min depth \(returnValue) for \(node.key)")
            return returnValue
        }
        func maxDepth(from node:Node<T>?) -> Int {
            guard let node = node else { return 0 }
            let returnValue = 1 + max(maxDepth(from: node.left),maxDepth(from: node.right))
            print("Got max depth \(returnValue) for \(node.key)")
            return returnValue
        }
        guard let root = root else { return true }
        let difference = maxDepth(from: root) - minDepth(from: root)
        return difference <= 1
    }
    
    //create your own description property that prints the tree in whatever way you find useful.
    var description: String {
        // when I print my array check the root property has a value
        guard let first = root else { return "(Empty)" }
        //init my empty queue
        var queue = [Node<T>]()
        // append the root
        queue.append(first)
        // init the output
        var output = ""
        
        // my q starts at 1
        while queue.count > 0 {
            var nodesAtCurrentLevel = queue.count
            // starts at 1 like my q count
            while nodesAtCurrentLevel > 0 {
                // first pass starts removing the root and appending to the output
                let node = queue.removeFirst()
                output += "\(node.key) "
                //update the queue before exiting with the children
                if node.left != nil { queue.append(node.left!) }
                if node.right != nil { queue.append(node.right!) }
                nodesAtCurrentLevel -= 1
            }
            // first pass I will have the root followed by \n and continue until there are no children and q is empty
            output += "\n"
        }
        //there are no children and q count is zero
            return output
    }
}

//So, the BinarySearchTree has one node, which is the root of the tree, and nothing else. It is another generic type, but this time with a constraint: the nodes it contains must store data that conforms to Comparable

[2, 1, 3]
let aa = BinarySearchTree(array: [2, 1, 3])
print(aa)


//The following values should create balanced trees:
BinarySearchTree(array: [2, 1, 3]).isBalanced()
BinarySearchTree(array: [5, 1, 7, 6, 2, 1, 9]).isBalanced()
BinarySearchTree(array: [5, 1, 7, 6, 2, 1, 9, 1]).isBalanced()
BinarySearchTree(array: [5, 1, 7, 6, 2, 1, 9, 1, 3]).isBalanced()
BinarySearchTree(array: [50, 25, 100, 26, 101, 24, 99]).isBalanced()
BinarySearchTree(array: ["k", "t", "d", "a", "z", "m", "f"]).isBalanced()
BinarySearchTree(array: [1]).isBalanced()
BinarySearchTree(array: [Character]()).isBalanced()

BinarySearchTree(array: [2, 1, 3]).isBalanced()
print(BinarySearchTree(array: [5, 1, 7, 6, 2, 1, 9]))
print(BinarySearchTree(array: [5, 1, 7, 6, 2, 1, 9, 1]))
print(BinarySearchTree(array: [5, 1, 7, 6, 2, 1, 9, 1, 3]))
print(BinarySearchTree(array: [50, 25, 100, 26, 101, 24, 99]))
print(BinarySearchTree(array: ["k", "t", "d", "a", "z", "m", "f"]))
BinarySearchTree(array: [1]).isBalanced()
print(BinarySearchTree(array: [Character]()))

//The following values should not create balanced trees:
BinarySearchTree(array: [1, 2, 3, 4, 5]).isBalanced()
BinarySearchTree(array: ["f", "d", "c", "e", "a", "b"]).isBalanced()

