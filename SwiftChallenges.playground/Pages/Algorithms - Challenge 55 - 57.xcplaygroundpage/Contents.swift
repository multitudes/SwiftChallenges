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



/*:

 # Challenge 57: Isomorphic values
 
 #### Difficulty: Easy

Write a function that accepts two values and returns true if they are isomorphic. That is, each
part of the value must map to precisely one other, but that might be itself.
 
Tip: Strings A and B are considered isomorphic if you can replace all instances of each letter with another. For example, "tort" and "pump" are isomorphic, because you can replace both Ts with a P, the O with a U, and the R with an M. For integers you compare individual digits, so 1231 and 4564 are isomorphic numbers. For arrays you compare elements, so [1, 2, 1] and [4, 8, 4] are isomorphic.
 
 Sample input and output
 
 These are all isomorphic values:
 
 • "clap" and "slap"
 
 • "rum" and "mud"
 
 • "pip" and "did"
 
 • "carry" and "baddy"
 
 • "cream" and "lapse"
 
 • 123123 and 456456
 
 • 3.14159 and 2.03048
 
 • [1, 2, 1, 2, 3] and [4, 5, 4, 5, 6]
 
 These are not isomorphic values:
 
 • "carry" and "daddy" – the Rs have become D, but C has also become D.
 
 • "did" and "cad" – the first D has become C, but the second has remained D.
 
 • "maim" and "same" – the first M has become S, but the second has become E.
 
 • "curry" and "flurry" – the strings have different lengths.
 
 • 112233 and 112211 – the number 1 is being mapped to 1, and the number 3 is also being mapped to 1.
 
 Hints

 Hint #1: Stringification holds the key to solve this problem simply. Your parameters should both be Any, and you can use the String(describing:) initializer to stringify them.

 Hint #2: You need to loop over all the characters in both stringified character arrays. To avoid out of bounds problems, make sure you start by checking both strings are the same length.

 Hint #3: You should store your character mappings using a dictionary of type [Character: Character].

 Hint #4: If you convert the characters of each string into an array you’ll find subscripting significantly easier.

 Hint #5: When you loop over each letter in the current string, you can check if it exists as a key in your character map. For characters that exist, check that its value matches the letter in the second string – if it doesn’t, it’s not an isomorphic string.

 Hint #6: If your letter doesn’t exist as a key in the character map, it’s possible the second string’s letter does exist as a value attached to a different key. If so, it’s not an isomorphic string.

 Hint #7: If the character isn’t already a key, and the second string’s letter isn’t already a value, then add the character and matching second string letter to your character mapping dictionary.

 Hint #8: If you’ve made it through all the characters in the first string and not encountered any problems, you have an isomorphic string.

 # Remember
 
 Insertion sort is the preferred sorting algorithm for arrays with fewer than 20 items and is used by Swift itself – this is one that’s worth getting right!
 
 [Next](@next)
*/


func challenge57(first: Any, second: Any) -> Bool {
    
    let firstString = String(describing: first)
    let secondString = String(describing: second)
    if firstString.count != secondString.count { return false }
    var firstDic = [Character: Character]()
    var secondDic = [Character: Character]()
    let firstArray = Array(firstString)
    let secondArray = Array(secondString)
    print(firstArray, secondArray)
    
    for i in 0 ..< firstArray.count {
        if firstDic[firstArray[i]] == nil {
            firstDic[firstArray[i]] = secondArray[i]
        } else {
            if firstDic[firstArray[i]] != secondArray[i] { return false}
        }
        if secondDic[secondArray[i]] == nil {
            secondDic[secondArray[i]] = firstArray[i]
        } else {
            if secondDic[secondArray[i]] != firstArray[i] { return false}
        }
        
    }
    return true
}

challenge57(first: 123123, second: 456456)
challenge57(first: "clap", second: "slap")
challenge57(first: "rum", second: "mud")
challenge57(first: "pip", second: "did")
challenge57(first: "carry", second: "baddy")
challenge57(first: "cream", second: "lapse")
challenge57(first: 123123, second: 456456)
challenge57(first: 3.14159, second: 2.03048)
challenge57(first: [1, 2, 1, 2, 3], second: [4, 5, 4, 5, 6])


//These are not isomorphic values:
challenge57(first: "carry", second: "daddy")
challenge57(first: "did", second: "cad")
challenge57(first: "maim", second: "same")
challenge57(first: "curry", second: "flurry")
challenge57(first: 112233, second: 112211)

func challenge57PaulsSolution(first firstValue: Any, second secondValue: Any) -> Bool {
    let first = String(describing: firstValue)
    let second = String(describing: secondValue)
    guard first.count == second.count else { return false }
    var characterMap = [Character: Character]()
    let firstArray = Array(first)
    let secondArray = Array(second)
    for (index, character) in firstArray.enumerated() {
        let otherCharacter = secondArray[index]
        if let currentMapping = characterMap[character] {
            if currentMapping != otherCharacter {
                return false
             }
        } else {
            if characterMap.values.contains(otherCharacter) {
                return false
             }
        characterMap[character] = otherCharacter }
    }
    return true
}

challenge57PaulsSolution(first: 123123, second: 456456)
challenge57PaulsSolution(first: "clap", second: "slap")
challenge57PaulsSolution(first: "rum", second: "mud")
challenge57PaulsSolution(first: "pip", second: "did")
challenge57PaulsSolution(first: "carry", second: "baddy")
challenge57PaulsSolution(first: "cream", second: "lapse")
challenge57PaulsSolution(first: 123123, second: 456456)
challenge57PaulsSolution(first: 3.14159, second: 2.03048)
challenge57PaulsSolution(first: [1, 2, 1, 2, 3], second: [4, 5, 4, 5, 6])


//These are not isomorphic values:
challenge57PaulsSolution(first: "carry", second: "daddy")
challenge57PaulsSolution(first: "did", second: "cad")
challenge57PaulsSolution(first: "maim", second: "same")
challenge57PaulsSolution(first: "curry", second: "flurry")
challenge57PaulsSolution(first: 112233, second: 112211)
