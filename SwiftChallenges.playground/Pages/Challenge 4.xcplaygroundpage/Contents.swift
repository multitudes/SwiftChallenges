/*:
 [Previous](@previous)

# Challenge 4: Does one string contain another?

## Difficulty: Easy
  
Write your own version of the contains() method on String that ignores letter case, and
without using the existing contains() method.

 Sample input and output
 • The code "Hello, world".fuzzyContains("Hello") should return true.
 • The code "Hello, world".fuzzyContains("WORLD") should return true.
 • The code "Hello, world".fuzzyContains("Goodbye") should return
 false.

 [Next](@next)
*/


import Foundation

extension String {
    func fuzzyContains(_ input: String) -> Bool {
        let a = self.lowercased().range(of: input.lowercased())
        return a != nil
    }
}

// second option
extension String {
    func fuzzyContains2(_ string: String) -> Bool {
        print(self.range(of: string, options: .caseInsensitive) ?? "doh")
        return range(of: string, options: .caseInsensitive) != nil
    }
}

"hello".fuzzyContains2("heh")



assert("Hello, world".fuzzyContains("Hello") == true, "Challenge failed")
assert("Hello, world".fuzzyContains("WORLD") == true, "Challenge failed")
assert("Hello, world".fuzzyContains("Goodbye") == false, "Challenge failed")

