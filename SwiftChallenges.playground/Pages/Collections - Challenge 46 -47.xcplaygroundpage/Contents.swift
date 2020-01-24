/*:
 [Previous](@previous)

 # Challenge 46: Recreate map()
 
 #### Difficulty: Tricky

Write an extension for all collections that reimplements the map() method.
 
 
 Sample input and output
 
 • The code [1, 2, 3].challenge46 { String($0) } should return [“1”, "2", "3"]
 
 • The code ["1", "2", "3"].challenge46 { Int($0)! } should return [1, 2, 3].
 
 #### Hints
 
 Hint #1: You’ll need to extend the Collection type.
 
 Hint #2: Your transformation function should accept a parameter of type Iterator.Element, but must return a generic parameter.
 
 Hint #3: You should accept transformation functions that throw, but you don’t want to handle any exceptions in your mapping method.
 
 Hint #4: Non-throwing functions are sub-types of throwing functions.
 
 Hint #5: You really ought to use rethrows to avoid irritating users who use non-throwing functions.
 
 [Next](@next)
*/

import Foundation

// the use of “throws” and “rethrows”. This is covered in detail in Pro Swift: marking the parameter with throws means only that it might throw, not that it will throw, and marking the whole thing as rethrows means it need be used with try/catch only when its parameter really does throw.
extension Collection {
    // generic method accepting a closure and returning a new type
    func challenge46<T>(_ transform: (Iterator.Element) throws -> T) rethrows -> [T]     {
        // create return array
        var returnValue = [T]()
        // loop over our items trying the transformation
        for item in self {
            returnValue.append(try transform(item))
        }
        return returnValue
    }
}

let a = [1, 2, 3].challenge46 { String($0) }
print(a)
let b = ["1", "2", "3"].challenge46 { Int($0)! } // should return [1, 2, 3].
print(b)

/*:
 [Previous](@previous)

 # Challenge 47: Recreate min()
 
 #### Difficulty: Tricky

Write an extension for all collections that reimplements the min() method.

 
 Sample input and output
 
 • The code [1, 2, 3].challenge47() should return 1.
 
 • The code ["q", "f", "k"].challenge47() should return “f”.
 
 • The code [4096, 256, 16].challenge47() should return 16.
 
 • The code [String]().challenge47() should return nil.

 #### Hints
 
 Hint #1: You’ll need to extend the Collection type with a constraint.
 
 Hint #2: Finding the smallest of any value requires using the < operator, which is guaranteed to exist when something conforms to Comparable.
 
 Hint #3: The collection might be empty, so you’ll need to return an optional value. Hint #4: You can’t compare an optional value against a non-optional one
 
 Hint #5: You can solve this quite beautifully using reduce().

 [Next](@next)
*/

extension Collection where Iterator.Element : Comparable {
    //make the lowest value an optional of the same type as our element
    func challenge47a() -> Iterator.Element? {
        var lowest : Iterator.Element?
        for item in self {
            // first time lowest will be nil.. For each item, unwrap our lowest and check whether the new item is lower
            if let unwrappedLowest = lowest {
                if item < unwrappedLowest {
                    lowest = item
                    print(unwrappedLowest)
                }
                // lowest will be my first item
            } else {
                lowest = item
            }
        }
        return lowest
        }
}

[1, 2, 3].challenge47a()        // should return 1.
["q", "f", "k"].challenge47a()  // should return “f”.
[4096, 256, 16].challenge47a()  // should return 16.
[String]().challenge47a()       // should return nil.



//if we can’t get at least one value from the collection we might as well early return.
// use guard to pull out self.first. If that returns nil it means the collection is empty so we can return nil immediately
// if it isn’t empty it means we definitely have a return value and can therefore forget about optionality the rest of the time.
extension Collection where Iterator.Element : Comparable {
    func challenge47b() -> Iterator.Element? {
        guard var lowest = self.first else {
            return nil
        }
        for item in self {
            if item < lowest {
                lowest = item
            }
        }
        return lowest
    }
}


[1, 2, 3].challenge47b()        // should return 1.
["q", "f", "k"].challenge47b()  // should return “f”.
[4096, 256, 16].challenge47b()  // should return 16.
[String]().challenge47b()       // should return nil.

//All collections are backed by an iterator, which is what produces elements and allows us to constrain extensions using Iterator.Element. They also come with a makeIterator() method, that allows you to move through the entire collection and pull out items by calling its next() method. The first time you call next() you’ll receive the first item; the second time you call it you’ll get the second, and so on. Helpfully, you can call these methods whenever and wherever you want – as long as you use the same iterator, your position will be preserved.
//So, rather than using self.first for our guard statement, we’ll instead create an iterator then use the first return value from its next() method. This means we can continue to loop over the iterator using a while loop and next(), and won’t compare the first value to itself.

extension Collection where Iterator.Element : Comparable {
    func challenge47c() -> Iterator.Element? {
        var it = makeIterator()
        guard var lowest = it.next() else { return nil }
        while let item = it.next() {
            if item < lowest {
                lowest = item
            }
        }
        return lowest
    }
}
[1, 2, 3].challenge47c()        // should return 1.
["q", "f", "k"].challenge47c()  // should return “f”.
[4096, 256, 16].challenge47c()  // should return 16.
[String]().challenge47c()       // should return nil.



extension Collection where Iterator.Element : Comparable {
    func challenge47d() -> Iterator.Element? {
        guard let lowest = self.first else { return nil }
        return reduce(lowest) { $1 < $0 ? $1 : $0 }
    }
}

[1, 2, 3].challenge47d()        // should return 1.
["q", "f", "k"].challenge47d()  // should return “f”.
[4096, 256, 16].challenge47d()  // should return 16.
[String]().challenge47d()       // should return nil.

//That code does suffer from the same problem we already tackled: it evaluates the first element twice. Sadly this is difficult to avoid with reduce(), because you can’t reduce an iterator.
//The workaround is the IteratorSequence data type
// I should add that there’s a cost to converting an iterator to a sequence, and it’s probably greater than the cost of evaluating one item twice.
extension Collection where Iterator.Element : Comparable {
    func challenge47e() -> Iterator.Element? {
        var it = makeIterator()
        guard let lowest = it.next() else { return nil }
        return IteratorSequence(it).reduce(lowest) {
            $1 < $0 ? $1 : $0
        }
    }
    // a sneaky solution: call sorted() then return its first property
    //far from the most efficient.
    func challenge47f() -> Iterator.Element? { return self.sorted().first
    }
}

[1, 2, 3].challenge47e()        // should return 1.
["q", "f", "k"].challenge47e()  // should return “f”.
[4096, 256, 16].challenge47e()  // should return 16.
[String]().challenge47e()       // should return nil.


[1, 2, 3].challenge47f()        // should return 1.
["q", "f", "k"].challenge47f()  // should return “f”.
[4096, 256, 16].challenge47f()  // should return 16.
[String]().challenge47f()       // should return nil.
