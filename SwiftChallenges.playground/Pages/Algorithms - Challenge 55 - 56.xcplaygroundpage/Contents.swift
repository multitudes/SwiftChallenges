/*:
 [Previous](@previous)

 # Challenge 55: Bubble sort
 
 #### Difficulty: Easy

Create an extension for arrays that sorts them using the bubble sort algorithm.
Tip: A bubble sort repeatedly loops over the items in an array, comparing items that are next to each other and swapping them if they aren’t sorted. This looping continues until all items are in their correct order.
 
 Sample input and output
 
 • The array[12, 5, 4, 9, 3, 2, 1]should become[1, 2, 3, 4, 5, 9, 12].
 
 • The array ["f", "a", "b"] should become ["a", "b", "f"].

 • The array [String]() should become [].

 Hints
 Hint #1: You’ll need to extend the Array type, but only when its elements conform to Comparable so you can establish a sort order.

 Hint #2: You want to repeat your loop while a condition is true, so repeat while makes sense.

 Hint #3: Watch out for the case when the array is empty.

 Hint #4: You can swap two values using the global swap() function like this  array.swapAt(a, b).

 Hint #5: If you try printing out the array after each sorting pass you might spot a pattern that you can use to optimize your code.

 
 [Next](@next)
*/
import Foundation

extension Array where Iterator.Element : Comparable {
    func bubbleSort() -> [Element] {
        guard count > 1 else { return self }
        var returnValue = self
        
        var swapsMade: Bool
        
        repeat {
            swapsMade = false
            
            for index in 0 ..< returnValue.count - 1 {
                let element = returnValue[index]
                let next = returnValue[index + 1]
                
                if element > next {
                    // swap
                    print("Before \(returnValue)")
                    returnValue.swapAt(index, index + 1 )
                    //mark swap made
                    swapsMade = true
                    print("After- \(returnValue)")
                }
            }
        } while swapsMade == true
        
        // exit loop and return
        return returnValue
    
    }
}


extension Array where Iterator.Element : Comparable {
    func bubbleSort2() -> [Element] {
        guard count > 0 else { return [Element]() }
        var returnValue = self
        var highestSortedIndex = count
        repeat {
            var lastSwapIndex = 0
            for index in 0 ..< highestSortedIndex - 1 {
                let element = returnValue[index]
                let next = returnValue[index + 1]
                if (element > next) {
                    returnValue.swapAt(index, index + 1)
                    lastSwapIndex = index + 1
                }
            }
            highestSortedIndex = lastSwapIndex
        } while highestSortedIndex != 0
        return returnValue
    }
}
[12, 5, 4, 9, 3, 2, 1].bubbleSort() // should become[1, 2, 3, 4, 5, 9, 12].

["f", "a", "b"].bubbleSort()  // should become ["a", "b", "f"].

[String]().bubbleSort() // should become [].


[12, 5, 4, 9, 3, 2, 1].bubbleSort2() // should become[1, 2, 3, 4, 5, 9, 12].

["f", "a", "b"].bubbleSort2()  // should become ["a", "b", "f"].

[String]().bubbleSort2() // should become [].


/*:

 # Challenge 56: Insertion sort
 
 #### Difficulty: Easy

Create an extension for arrays that sorts them using the insertion sort algorithm.
Tip: An insertion sort creates a new, sorted array by removing items individually from the input array and placing them into the correct position in the new array.

 Sample input and output
 
 • The array[12, 5, 4, 9, 3, 2, 1]should become[1, 2, 3, 4, 5, 9, 12].
 
 • The array ["f", "a", "b"] should become ["a", "b", "f"].
 
 • The array [String]() should become [].

 Hints

 Hint #1: You can perform insertion sort in-place, but that takes a little more thinking. Aim for correctness first, and efficiency later.

 Hint #2: You will need to extend Array with a constraint on their elements so that they must be Comparable – that’s what lets us sort items.

 Hint #3: In the most simple solution, you should be able to pick out an item from your source array, then search through your sorted destination array to find where it should go.

 Hint #4: If you want to try the in-place solution, pull out the current item you want to sort, then keep moving other elements to the right until you find the correct spot for your item.

 - Insertion sort is much like bubble sort: it’s generally considered a bad choice for a real-world search algorithm, but it’s easy enough to teach
 - However, insertion sort is always faster than bubble sort, and in fact it’s the preferred choice of algorithm if you’re sorting small data sets
 
 # Remember
 
 Insertion sort is the preferred sorting algorithm for arrays with fewer than 20 items and is used by Swift itself – this is one that’s worth getting right!
 
 [Next](@next)
*/

extension Array where Element: Comparable {
    func insertionSort() -> [Element] {
        guard count > 1 else { return self }
        
        var returnValue = [Element]()
        
        for unsorted in self {
            if returnValue.count == 0 {
                returnValue.append(unsorted)
            } else {
                var placed = false
                
                for (index, sorted) in returnValue.enumerated() {
                    if unsorted < sorted {
                        returnValue.insert(unsorted, at: index)
                        placed = true
                        break
                    }
                }
                if !placed {
                    returnValue.append(unsorted)
                }
                
            }
            
        }
        return returnValue
    }
}

[12, 5, 4, 9, 3, 2, 1].insertionSort() //should become[1, 2, 3, 4, 5, 9, 12].

["f", "a", "b"].insertionSort() // should become ["a", "b", "f"].

[String]().insertionSort() // should become []


extension Array where Element: Comparable {
    func insertionSortInPlace() -> [Element] {
        guard count > 1 else { return self }
        
        var returnValue = self
        
        for i in 1 ..< count {
            var currentItemIndex = i
            // take a copy of the current item
            let itemToPlace = returnValue[currentItemIndex]
            // keep going around until we're at the start of the or find an item that's greater or equal to us
            while currentItemIndex > 0 && itemToPlace < returnValue[currentItemIndex - 1] {
                // move this item to the right
                returnValue[currentItemIndex] = returnValue[currentItemIndex - 1]
                currentItemIndex -= 1
            }
            // We are out of the loop - place our item into its newly sorted place
            returnValue[currentItemIndex] = itemToPlace
        }
        return returnValue
    }
}
[12, 5, 4, 9, 3, 2, 1].insertionSortInPlace() //should become[1, 2, 3, 4, 5, 9, 12].

["f", "a", "b"].insertionSortInPlace() // should become ["a", "b", "f"].

[String]().insertionSortInPlace() // should become []
