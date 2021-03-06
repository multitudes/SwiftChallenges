//: [Previous](@previous)




//: [Next](@next)


import Foundation
let docsPath = Bundle.main.resourcePath!
print(docsPath)
let urls = try? Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "dataset/train")![0]
print(urls!)


func check(in string: String, forAnyIn characters: String) -> Bool {
    let customSet = CharacterSet(charactersIn: characters)
    let inputSet = CharacterSet(charactersIn: string)
    return !inputSet.intersection(customSet).isEmpty
}

func check2(in string: String, forAnyIn characters: String) -> Bool {
    let customSet = CharacterSet(charactersIn: characters)
    return string.rangeOfCharacter(from: customSet) != nil }

check(in: "abc", forAnyIn: "A")
check(in: "abc", forAnyIn: "b")


check2(in: "abc", forAnyIn: "A")
check2(in: "abc", forAnyIn: "b")

var input = "class1{name=‘adam.smith’}.class2{name=‘john’}.subjectMath"

func splittingClasses(_ input: String) -> [String] {
    var total: [String] = []
    var parts = input.components(separatedBy: "}.")
    let endpart =  "}"
    for i in 0 ..< parts.count {
        if i == parts.count - 1 {
            total.append(parts[i])
        } else {
            total.append(parts[i] + endpart)
        }
    }
    print(total)
    return total
}
splittingClasses(input)


// this might be useful later!
extension StringProtocol {
    func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
let inputString = "323 ECO Economics Course 451 ENG English Course 789 Mathematical Topography"

let courses = inputString.ranges(of: "\\b[0-9]{1,}[a-zA-Z ]{1,}", options: .regularExpression).map{inputString[$0] }

print(courses)   //   ["323 ECO Economics Course ", "451 ENG English Course ", "789 Mathematical Topography"]


extension URL {
    var isDirectory: Bool {
        return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    var subDirectories: [URL] {
        guard isDirectory else { return [] }
        return (try? FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]).filter{ $0.isDirectory }) ?? []
    }
}
let documentsDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

let subDirs = documentsDirectoryURL.subDirectories
