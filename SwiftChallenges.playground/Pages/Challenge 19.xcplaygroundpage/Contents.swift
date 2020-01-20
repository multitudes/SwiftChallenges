/*:
 [Previous](@previous)

#  Challenge 19: Swap two numbers

 ## Difficulty: Easy
 
 Swap two positive variable integers, a and b, without using a temporary variable.
 Sample input and output
 • Before running your code a should be 1 and b should be 2; afterwards, b should be 1 and a should be 2.

 [Next](@next)
*/
import Foundation

func challenge19(a: Int, b: Int) -> (a: Int, b: Int) {
    return (b, a)
}

var a = challenge19(a: 2, b: 3).a

var b = challenge19(a: 2, b: 3).b

// without temp! without tuples!
// a=a+b
// b=a-b
// a=a-b
// That’s the solution you’d use in most languages

// can also use XOR like this:
var e = 15
var f = 1
e = e^f
f = e^f
e = e^f

// Swift gives us two alternatives. First, there’s a global swap() function that swaps two values of the same type, like this:
var (c,d) = (2,3)
swap(&c, &d)
print((c,d))

// A second idiomatic solution is to use tuples. This delivers a beautifully solution to the challenge that is also undeniably Swifty:
(a, b) = (b, a)


/*:
 [Previous](@previous)

#  Challenge 20: Number is prime

 ## Difficulty: Tricky
 
 Write a function that accepts an integer as its parameter and returns true if the number is prime.
 Tip: A number is considered prime if it is greater than one and has no positive divisors other than 1 and itself.

 The number 11 should return true.
 • The number 13 should return true.
 • The number 4 should return false.
 • The number 9 should return false.
 • The number 16777259 should return true.
 
 [Next](@next)
*/

func challenge20(_ prime: Int) -> Bool {
    guard prime >= 2 else { return false }
    guard prime != 2 else { return true }
    let ceiling = Int(Double(prime).squareRoot().rounded())
    //print(ceiling)
    for i in 2 ... ceiling {
        if Int(prime) % i == 0 {
            return false
        }
    }
    return true
}

challenge20(23)
challenge20(1)
// There’s no point searching higher than the square root of your input number, rounding up.
// Proof: The definition of a prime number is a positive integer that has exactly two positive divisors. However, 1 only has one positive divisor (1 itself), so it is not prime.

assert(challenge20(11) == true , "fail")
assert(challenge20(13) == true , "fail")
assert(challenge20(4) == false , "fail")
assert(challenge20(9) == false , "fail")
assert(challenge20(16777259) == true , "fail")
                

/*:
 [Previous](@previous)

#  Challenge 21: Counting binary ones

 ## Difficulty: Tricky
 
 Create a function that accepts any positive integer and returns the next highest and next lowest number that has the same number of ones in its binary representation. If either number is not possible, return nil for it.
 Sample input and output

 • The number 12 is 1100 in binary, so it has two 1s. The next highest number with that many 1s is 17, which is 10001. The next lowest is 10, which is 1010.
 • The number 28 is 11100 in binary, so it has three 1s. The next highest number with that many 1s is 35, which is 100011. The next lowest is 26, which is 11010.

 
 [Next](@next)
*/


// This is a classic computing science problem

func challenge21(_ number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    var nextHighest : Int?
    var nextLowest : Int?
    guard number > 0 else { return (nextHighest: nextHighest, nextLowest: nextLowest) }
    
    let binaryString = String(number, radix: 2)
    print(binaryString)
    
    let numberOfOnes = binaryString.filter(){ $0 == "1" }.count
    var high = number + 1
    var low = number - 1
    while true {
        let highNumberOfOnes = String(high, radix: 2).filter(){ $0 == "1" }.count
        if highNumberOfOnes == numberOfOnes { break }
        high += 1
    }
    
    while true {
        let lowNumberOfOnes = String(low, radix: 2).filter(){ $0 == "1" }.count
        if lowNumberOfOnes == numberOfOnes { break }
        low -= 1
    }
    nextLowest = Int(String(low, radix: 2), radix: 10)
    nextHighest = Int(String(high, radix: 2), radix: 10)
    print("high: \(nextHighest), low: \(nextLowest)")

    return (nextHighest: high, nextLowest: low)
}

challenge21(12)

assert(challenge21(12) == (nextHighest: 17, nextLowest: 10), "fail")
assert(challenge21(28) == (nextHighest: 35, nextLowest: 26), "fail")
//assert(challenge15("The quick brown fox") == "ehT kciuq nworb xof", "fail")


// refactoring a bit
func challenge21a(_ number: Int) -> (nextHighest: Int?, nextLowest: Int?) {
    var nextHighest : Int?
    var nextLowest : Int?
    guard number > 0 else { return (nextHighest: nextHighest, nextLowest: nextLowest) }
    
    func ones(in number: Int) -> Int {
        let binaryString = String(number, radix: 2)
        return binaryString.filter(){ $0 == "1" }.count
    }
    let numberOfOnes = ones(in: number)
    var high = number + 1
    var low = number - 1
    while true {
        if ones(in: high) == numberOfOnes { break }
        high += 1
    }
    while true {
        if ones(in: low) == numberOfOnes { break }
        low -= 1
    }
    nextLowest = Int(String(low, radix: 2), radix: 10)
    nextHighest = Int(String(high, radix: 2), radix: 10)
    print("high: \(nextHighest), low: \(nextLowest)")

    return (nextHighest: high, nextLowest: low)
}



assert(challenge21a(12) == (nextHighest: 17, nextLowest: 10), "fail")
assert(challenge21a(28) == (nextHighest: 35, nextLowest: 26), "fail")
//assert(challenge15("The quick brown fox") == "ehT kciuq nworb xof", "fail")



/*:
 [Previous](@previous)

#  Challenge 22: Binary reverse

 ## Difficulty: Tricky
 
 Create a function that accepts an unsigned 8-bit integer and returns its binary reverse, padded
 so that it holds precisely eight binary digits.
 Tip: When you get the binary representation of a number, Swift will always use as few bits as possible – make sure you pad to eight binary digits before reversing.
 Sample input and output
 • The number 32 is 100000 in binary, and padded to eight binary digits that’s 00100000. Reversing that binary sequence gives 00000100, which is 4. So, when given the input 32 your function should return 4.
 • The number 41 is 101001 in binary, and padded to eight binary digits that 00101001. Reversing that binary sequence gives 10010100, which is 148. So, when given the input 41 your function should return 148.
 • It should go without saying that your function should be symmetrical: when fed 4 it should return 32, and when fed 148 it should return 41.

 
 [Next](@next)
*/
