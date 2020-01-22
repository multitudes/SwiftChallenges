/*:
 [Previous](@previous)

#  Challenge 24: Add numbers inside a string

 ### Difficulty: Tricky
 
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
    //print(matches)
    let allNumbers = matches.compactMap { Int((string as NSString).substring(with: $0.range)) }
    return allNumbers.reduce(0, +)
}

challenge24b("a1b2c3")
challenge24b("a10b20c30")
challenge24b("h8ers")

/*:
 [Previous](@previous)

 # Challenge 25: Calculate a square root by hand

 ### Difficulty: Taxing
 
 Write a function that returns the square root of a positive integer, rounded down to the nearest
 integer, without using sqrt().
 Sample input and output
 
 • The number 9 should return 3.
 
 • The number 16777216 should return 4096.
 
 • The number 16 should return 4.
 
 • The number 15 should return 3.
 
 [Next](@next)
*/

func challenge25(_ input: Int) -> Int {
    guard input != 1 else { return 1 }
    guard input > 0 else { return 0 }
    var low = 0
    var high = input / 2 + 1
    
    while (low + 1 ) < high {
        let mid = ((high - low) / 2 ) + low
        print(mid)
        if (mid * mid) == input { return mid }
        if (mid * mid) < input {
            low = mid
        } else { high = mid }
    }
    return low
}

challenge25(9)
challenge25(16777216) //4096
challenge25(16)
challenge25(15)



/*:
Like most coding interview problems, this one has a naïve solution, a smart solution, and a sneaky solution.
*/
func challenge25a(_ input: Int) -> Int {
    guard input != 1 else { return 1 }
    for i in 0 ... input / 2 + 1 {
        if i * i > input {
            return i - 1 }
    }
    return 0
}

challenge25a(9)
challenge25a(16777216) //4096
challenge25a(16)
challenge25a(15)

/*:
 
 A smarter solution is to use a binary search, which massively reduces the search space.  (this was my solution above..
 
 there’s also a sneaky approach
 here’s how to solve the challenge using pow()
 9½ × 9½ = 9(½+½) = 9(1) = 9
 */

func challenge25c(_ input: Int) -> Int {
return Int(floor(pow(Double(input), 0.5)))
}

challenge25c(9)
challenge25c(16777216) //4096
challenge25c(16)
challenge25c(15)


/*:
 [Previous](@previous)

 # Challenge 26: Subtract without subtract
 
 ### Difficulty: Taxing

 Create a function that subtracts one positive integer from another, without using -.

 Sample input and output
 
• The code challenge26(subtract: 5, from: 9) should return 4.
 
• The code challenge26(subtract: 10, from: 30) should return 20.

 
 This technique depends on the ~ operator (a tilde), which is bitwise NOT. It causes all the binary digits in a number to be flipped. If this is not new to you, skip ahead – I’m going to take a brief tangent into what it does behind the scenes.
 
 To subtract one number from another, we flip the bits (64 becomes -65) then add one (to make -64), and add that to our input number to make subtraction. Done!
 [Next](@next)
*/


func challenge26(substract: Int, from: Int) -> Int {
    return from + ( ~substract + 1)
}

challenge26(substract: 5, from: 9)

~1
