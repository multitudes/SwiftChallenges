/*:
 [Previous](@previous)

#  Challenge 16: Fizz Buzz
 
### Difficulty: Easy
 
 Write a function that counts from 1 through 100, and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.

 Sample input and output
 
 • 1 should print “1”
 
 • 2 should print “2”
 
 • 3 should print “Fizz”
 
 • 4 should print “4”
 
 • 5 should print “Buzz”
 
 • 15 should print “Fizz Buzz”
 
 [Next](@next)
*/

import Foundation


func challenge16() {
    //Remember to use the closed range operator to include the number 100 at the end!
    for i in 1...100 {
        if i % 3 == 0 && i % 5 == 0 {
            print("FizzBuzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

challenge16()
//slightly more efficient by nesting the “Fizz Buzz” case
func challenge16b() {
    for i in 1...100 {
        if i % 3 == 0 {
            if i % 5 == 0 {
                print("Fizz Buzz")
            } else {
                print("Fizz")
            }
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

challenge16b()

// by paul!
func challenge16c() {
    (0...100).forEach {
        print($0 % 3 == 0 ? $0 % 5 == 0 ? "Fizz Buzz" : "Fizz" : $0 % 5 == 0 ? "Buzz" : "\($0)")
    }
}

challenge16c()


/*:
 [Previous](@previous)

#  Challenge 17: Generate a random number in a range
 
 ### Difficulty: Easy
 
 Write a function that accepts positive minimum and maximum integers, and returns a random
 number between those two bounds, inclusive.
 
 Sample input and output
 
 • Given minimum 1 and maximum 5, the return values 1, 2, 3, 4, 5 are valid.
 
 • Given minimum 8 and maximum 10, the return values 8, 9, 10 are valid.
 
 • Given minimum 12 and maximum 12, the return value 12 is valid.
 
 • Given minimum 12 and maximum 18, the return value 7 is invalid.
 
 
 [Next](@next)
*/
//If you used rand() you probably came from a C background, or don’t generally care about randomness.
//If you used GameplayKit, you’re either fairly new to iOS development, or particularly interested in the random number generation shaping GameplayKit offers
//If you used arc4random() you’re showing some awareness of half-decent random number generator, but are unaware of – or uninterested in – modulo bias.
//If you used arc4random_uniform(), then you’re showing some serious chops.

//Of the four options, arc4random_uniform() is preferred amongst developers, because it generates suitably random numbers for most purposes, it doesn’t require seeding, it isn’t prone to modulo bias, and it isn’t restricted to Apple platforms – it’s a commonly used C function that is well understood.


func challenge17(from: UInt32, to: UInt32) -> UInt32 {
    let range = to + 1 - from
    let randomNumber = arc4random_uniform(range) + from
    print(randomNumber)
    
    return randomNumber
}


challenge17(from: 1, to: 2)


// or from Paul

func challenge17b(min: Int, max: Int) -> Int {
return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}

challenge17b(min: 56, max: 75)

/*:
 [Previous](@previous)

#  Challenge 18: Recreate the pow() function
 
## Difficulty: Easy
 
 Create a function that accepts positive two integers, and raises the first to the power of the
 second.
 Tip: If you name your function myPow() or challenge18(), you’ll be able to use the
 built-in pow() for your tests. The built-in pow() uses doubles, so you’ll need to typecast.

 Sample input and output
 
 • The inputs 4 and 3 should return 64, i.e. 4 multiplied by itself 3 times.
 
 • The inputs 2 and 8 should return 256, i.e. 2 multiplied by itself 8 times.
 
 [Next](@next)
*/

func challenge18(base: Int, power: Int) -> Int {
    guard base > 0, power >= 0 else { return 0 }
    if power == 0 { return 1 }
    return Int(pow(Double(base), Double(power)))
}

challenge18(base: 0, power: 5)

// also
func challenge18b(base: Int, power: Int) -> Int {
    guard base > 0, power >= 0 else { return 0 }
    if power == 0 { return 1 }
    return base * challenge18b(base: base, power: power - 1)
}

challenge18b(base: 2, power: 5)

