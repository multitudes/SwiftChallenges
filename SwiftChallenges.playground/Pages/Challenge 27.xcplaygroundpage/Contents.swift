/*:
 [Previous](@previous)

 # Challenge 27: Print last lines
 ## Diffculty: Easy

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

challenge27(2)
challenge27(100)


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

challenge27a(2)
challenge27a(100)


/*:
 [Previous](@previous)

 # Challenge 28: Log a message
 ## Diffculty: Easy

Write a logging function that accepts accepts a path to a log file on disk as well as a new log message. Your function should open the log file (or create it if it does not already exist), then append the new message to the log along with the current time and date.
Tip: It’s important that you add line breaks along with each message, otherwise the log will just become jumbled.
Sample input and output
 
• If the file does not exist, running your function should create it and save the new message.
  
• If it does exist, running your function should load the existing content and append the message to the end, along with suitable line breaking.
  
 [Next](@next)
*/
