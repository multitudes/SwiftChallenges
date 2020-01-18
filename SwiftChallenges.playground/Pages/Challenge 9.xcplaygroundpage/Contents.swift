/*:
 [Previous](@previous)

# Challenge 9: Find pangrams

 ## Difficulty: Tricky
 
Write a function that returns true if it is given a string that is an English pangram, ignoring
letter case.
Tip: A pangram is a string that contains every letter of the alphabet at least once.

Sample input and output
The string “The quick brown fox jumps over the lazy dog” should return true.
• The string “The quick brown fox jumped over the lazy dog” should return false,
because it’s missing the S.


 [Next](@next)
*/

import Foundation

func challenge9(_ string: String) -> Bool {
    let pangram = Set(string.lowercased().filter { $0 >= "a" && $0 <= "z" })
    print(pangram.count)
    
    return pangram.count == 26
}

assert(challenge9("The quick brown fox jumps over the lazy dog") == true, "fail")
assert(challenge9("The quick brown fox jumped over the lazy dog") == false, "fail")


/*:
 [Previous](@previous)

# Challenge 10: Vowels and consonants


 ## Difficulty: Tricky
 
 Given a string in English, return a tuple containing the number of vowels and consonants.
 Tip: Vowels are the letters, A, E, I, O, and U; consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.
 Sample input and output
 • The input “Swift Coding Challenges” should return 6 vowels and 15 consonants.
 • The input “Mississippi” should return 4 vowels and 7 consonants.


 [Next](@next)
*/

func challenge10(_ string: String) -> (vowels: Int, consonants: Int) {
    let vowels = ["A", "E", "I", "O", "U"]
    let consonants = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
    var vowelCount = 0
    var consonantsCount = 0
    string.uppercased().forEach() { character in
        if vowels.contains(String(character)){
            vowelCount += 1
        }
        if consonants.contains(String(character)){
            consonantsCount += 1
        }
    }
    return(vowels: vowelCount, consonants: consonantsCount)
}


assert(challenge10("Swift Coding Challenges") == (vowels: 6, consonants: 15), "fail")
assert(challenge10("Mississippi") == (vowels: 4, consonants: 7), "fail")

func challenge10a(_ input: String) -> (vowels: Int, consonants: Int) {
    //A CharacterSet represents a set of Unicode-compliant characters. Foundation types use CharacterSet to group characters together for searching operations, so that they can find any of a particular set of characters during a search.
    let vowels = CharacterSet(charactersIn: "aeiou")
    let consonants = CharacterSet(charactersIn: "bcdfghjklmnpqrstvwxyz")
    var vowelCount = 0
    var consonantCount = 0
    for letter in input.lowercased() { let stringLetter = String(letter)
        print(stringLetter.rangeOfCharacter(from: vowels))
    if stringLetter.rangeOfCharacter(from: vowels) != nil {
        vowelCount += 1
        } else if stringLetter.rangeOfCharacter(from: consonants) != nil {
        consonantCount += 1
        }
    }
   return (vowelCount, consonantCount)
}

assert(challenge10a("Swift Coding Challenges") == (vowels: 6, consonants: 15), "fail")
assert(challenge10a("Mississippi") == (vowels: 4, consonants: 7), "fail")
