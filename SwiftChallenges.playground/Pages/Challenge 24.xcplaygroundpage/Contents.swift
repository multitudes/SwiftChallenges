/*:
 [Previous](@previous)

#  Challenge 24: Add numbers inside a string

 ## Difficulty: Tricky
 
 Given a string that contains both letters and numbers, write a function that pulls out all the
 numbers then returns their sum.
 
 Sample input and output :
 
 • The string “a1b2c3” should return 6 (1 + 2 + 3).
 
 • The string “a10b20c30” should return 60 (10 + 20 + 30)
 
 • The string “h8ers” should return “8”.
 

 [Next](@next)
*/

import Foundation


func challenge24(_ string: String) -> String {
    var digitsString: [String]
    //var seen: Bool = false
    digitsString = string.components(separatedBy:.letters).filter(){ $0 != "" }
    print(digitsString)
    var sum = 0
    for (number) in digitsString {
        print(number)
        sum = sum + Int(number)!
    }
    if digitsString.count == 1 { return String(sum) }
    var result : String = String(sum) + "(" + digitsString.joined(separator: "+").dropFirst(0) + ")"
    print(sum)
    print(result)
    return result
}

challenge24("a1b2c3")
challenge24("a10b20c30")
challenge24("h8ers")

func challenge24a(_ string: String) -> Int { var currentNumber = ""
    var sum = 0
    for letter in string {
        let strLetter = String(letter)
        if Int(strLetter) != nil {
            currentNumber += strLetter
        } else {
            sum += Int(currentNumber) ?? 0
            currentNumber = ""
        }
    }
    sum += Int(currentNumber) ?? 0
    return sum
}
challenge24a("a1b2c3")
challenge24a("a10b20c30")
challenge24a("h8ers")

// ok .. this is from paul. Regex in swift are tough

func challenge24b(_ string: String) -> Int {
    let regex = try! NSRegularExpression(pattern: "(\\d+)", options: [])
    let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
    print(matches)
    let allNumbers = matches.compactMap { Int((string as NSString).substring(with: $0.range)) }
    
    return allNumbers.reduce(0, +)
}

challenge24b("a1b2c3")
challenge24b("a10b20c30")
challenge24b("h8ers")
