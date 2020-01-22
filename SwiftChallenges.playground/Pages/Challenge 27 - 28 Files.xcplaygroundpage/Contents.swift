/*:
 [Previous](@previous)

 # Challenge 27: Print last lines
 ## Difficulty: Easy

Write a function that accepts a filename on disk, then prints its last N lines in reverse order, all
on a single line separated by commas.

 Sample input and output
Here is your test input file:
 
Antony And Cleopatra
Coriolanus
Cymbeline
Hamlet
Julius Caesar
King Lear
Macbeth
Othello
Twelfth Night  
 
 
 • If asked to print the last 3 lines, your code should output “Twelfth Night, Othello, Macbeth”.
 
 • If asked to print the last 100 lines, your code should output “Twelfth Night, Othello, Macbeth, King Lear, Julius Caesar, Hamlet, Cymbeline, Coriolanus, Antony and Cleopatra”.
 
 • If asked to print the last 0 lines, your could should print nothing.
 
 
 [Next](@next)
*/


import Foundation
import PlaygroundSupport

func challenge27(_ lines: Int) {
    var linesText: [String] = []
    do {
        guard let fileUrl = Bundle.main.url(forResource: "File", withExtension: "txt") else { fatalError() }
        linesText = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8).components(separatedBy: "\n").filter {$0 != "" }
        // for debug
        //print(input)
    } catch {
        // if something did not work out with the input file
        print(error)
    }
    print(linesText)
    var linesToPrint = 0
    if lines > linesText.count { linesToPrint = linesText.count } else { linesToPrint = lines }
   
    for i in 0..<linesToPrint {
        print(linesText[i])
    }
    
    
}

//challenge27(2)
//challenge27(100)


// This is from paul
func challenge27a(_ lineCount: Int) {
    var lines: [String] = []
    do {
        guard let fileUrl = Bundle.main.url(forResource: "File", withExtension: "txt") else { fatalError() }
        lines = try String(contentsOf: fileUrl, encoding: String.Encoding.utf8).components(separatedBy: "\n").filter {$0 != "" }
        // for debug
        //print(input)
    } catch {
        // if something did not work out with the input file
        print(error)
    }
    guard lines.count > 0 else { return }
    lines.reverse()
    for i in 0 ..< min(lines.count, lineCount) {
        print(lines[i])
    }
}

//challenge27a(2)
//challenge27a(100)


/*:
 [Previous](@previous)

 # Challenge 28: Log a message
 ## Difficulty: Easy

Write a logging function that accepts accepts a path to a log file on disk as well as a new log message. Your function should open the log file (or create it if it does not already exist), then append the new message to the log along with the current time and date.
Tip: It’s important that you add line breaks along with each message, otherwise the log will just become jumbled.
Sample input and output
 
• If the file does not exist, running your function should create it and save the new message.
  
• If it does exist, running your function should load the existing content and append the message to the end, along with suitable line breaking.
  
 [Next](@next)
*/
extension FileManager {
    static var documentDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
func writeLog(message: String, fileURL: URL){
    do {
        try message.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        //print(message)
    } catch {
        print("Failed to write to log: \(error.localizedDescription)")
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    }
}
func challenge28(_ logFile: String, message: String) {
    var log = ""
    let fileURL = FileManager.documentDirectoryURL.appendingPathComponent(logFile)
        
    print(fileURL)
    if let content = try? String(contentsOf: fileURL) {
        print("doh-  appending- file exists")
        // append log
        log = content + "\n"
        log.append("\(Date()): \(message)")
        print(log)
        writeLog(message: log, fileURL: fileURL)
    } else {
            print("making file")
            writeLog(message: message, fileURL: fileURL)
    }
}
challenge28("log.txt", message: "try harder!")


/*:
 actually I did not need to write an extra function. if there is no file I default to "" and write..
 This is from Paul however because i am in a playgroiund I get "Failed to write to log: You can’t save the file “txt” because the volume is read only."
 */
//
//func challenge28a(log message: String, to logFile: String) {
//
//    var existingLog = (try? String(contentsOfFile: logFile)) ?? ""
//    existingLog.append("\(Date()): \(message)\n")
//    do {
//        try existingLog.write(toFile: logFile, atomically: true, encoding: .utf8)
//    } catch {
//        print("Failed to write to log: \(error.localizedDescription)")
//    }
//}
//
//challenge28a(log: "paul said it", to: "~/Documents/log.txt")
