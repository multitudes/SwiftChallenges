/*:
 # StackOverflow answer
 
 
 
 : [Next](@next)
 */

import Foundation

// This is a test struct
public struct Test: Codable {
    var test = ""
}
// this is the initialisation of the empty struct to be filled from json
var unicodetest: Test = Test()

func parse(json: Data) {
    let decoder = JSONDecoder()
    if let testmodel = try? decoder.decode(Test.self, from: json) {
        unicodetest = testmodel
        print(unicodetest.test)
    }
}
// Here I get my Json and parse with the above function
do {
    guard let fileUrl = Bundle.main.url(forResource: "test", withExtension: "json") else { fatalError() }
    let input = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8).map {String($0)}.filter {$0 != "\\"}.joined(separator: "")
    if let sanitisedData = input.replacingOccurrences(of: "U(.*?)", with: "\\\\u$1",  options: .regularExpression).data(using: .utf8){
        parse(json: sanitisedData)
    }
} catch {
    // if something did not work out 
    print(error)
}

var string = "String(UnicodeScalar(Int($1, radix: 16)!)!)"
let txt = "Lorem ipsum U1234 dolores"
let newString = txt.replacingOccurrences(of: "U(.?)", with: "\\\\u$1", options: .regularExpression)
print(newString)
