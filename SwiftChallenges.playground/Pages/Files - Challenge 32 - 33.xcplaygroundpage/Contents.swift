/*:
 [Previous](@previous)

 # Challenge 32: Word frequency
 ### Difficulty: Tricky

Write a function that accepts a filename on disk, loads it into a string, then returns the frequency of a word in that string, taking letter case into account. How you define “word” is worth considering carefully.

 #### Sample input and output
 
 • A file containing “Hello, world!” should return 1 for “Hello”
 
 • A file containing “Hello, world!” should return 0 for “Hello,” – note the comma at the end.
 
 • A file containing “The rain in Spain falls mainly on the plain” should return 1 for  Spain, and 1 for “in”; the “in” inside rain, Spain, mainly, and plain does not count because it’s not a word by itself.
 
 • A file containing “I’m a great coder” should return 1 for “I’m”.
 
 Tip: Create different files on your desktop for each of your pieces of sample input, then pass the paths to those files into your function.
 
 ## Hints
 
 Hint #1: Being able to ask questions about definitions – “what is a word?” is an important skill in white boarding tests.
 
 Hint #2: I would suggest that splitting by any non-alphabetic character is a safe choice for defining words to begin with, but watch out for that last test case.
 
 Hint #3: There’s a built-in character set for letters, which includes uppercase and lowercase letters.
 
 Hint #4: All character sets have an inverted property that gives you the opposite. For letters that gives you all non-letters.
 
 [Next](@next)
*/

import Foundation

func challenge32(filePath: String, word: String) -> Int {
    var count = 0
    let fm = FileManager.default
    let fileURL = URL(fileURLWithPath: filePath)
    guard let content = try? String(contentsOf: fileURL) else { return 0 }
    var nonLetters = CharacterSet.letters.inverted
    print(nonLetters)
    nonLetters.remove("'")
    let parts = content.components(separatedBy: nonLetters)
    
    for part in parts {
        print(part)
        if part == word {
        count += 1
        }
    }
    
    return count
}

challenge32(filePath: "/Users/laurentb/Documents/testss/output.txt", word: "long")
challenge32(filePath: "/Users/laurentb/Documents/testss/output.txt", word: "Super")

challenge32(filePath: "/Users/laurentb/Documents/testss/output.txt", word: "I'm")


// with NSCountedSet
//As a side benefit, you also get the flexibility benefit from the dictionary code, in that if you need to query other words you can do so for free because all the work has been done up front.
func challenge32a(filePath: String, word: String) -> Int {
 var count = 0
 let fm = FileManager.default
 let fileURL = URL(fileURLWithPath: filePath)
 guard let content = try? String(contentsOf: fileURL) else { return 0 }
 var nonLetters = CharacterSet.letters.inverted
 print(nonLetters)
 nonLetters.remove("'")
 let parts = content.components(separatedBy: nonLetters)
    let wordset = NSCountedSet(array: parts)
    return wordset.count(for: word)
}

challenge32a(filePath: "/Users/laurentb/Documents/testss/output.txt", word: "long")
challenge32a(filePath: "/Users/laurentb/Documents/testss/output.txt", word: "Super")
challenge32a(filePath: "/Users/laurentb/Documents/testss/output.txt", word: "I'm")
