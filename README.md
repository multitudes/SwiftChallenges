# Swift Coding Challenges for Xcode Playgrounds

These are my Playgrounds to practice Interview Swift Challenges taken from the [book](https://www.hackingwithswift.com/store/swift-coding-challenges) by Paul Hudson.

Playgrounds are tricky. Especially because of sandboxing some basic operations like writing and reading from a file on disk are more complex and make an easy challenge a tricky one! 

![](SwiftChallenges.png)

An example of a Challenge which will create a new Log file or append a message to an existing log file along with the date and time.

```swift

// I created this extension. in iOS and the playgrounds I am only able to save and create documents in my Document directory. This directory is in the Users Documents folder on macOS and in the sandbox in iOS
extension FileManager {
    static var documentDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
// This function takes two parameters, the name of my file and the log message.
// by default the file will be saved to the .documentDirectory, in: .userDomainMask
func challenge28b(_ logFile: String, message: String) {
    // create the url using my FileManager extension documentDirectoryURL
    // my fileURL will look like ex /Users/laurentb/Documents/log.txt
    let fileURL = FileManager.documentDirectoryURL.appendingPathComponent(logFile)
    // I am using nil coalescing to check the contents of my file first. if it doesnt exist then it will be empty
    var log = (try? String(contentsOf: fileURL)) ?? ""
    // the variable log will have the contents of my file. I append my new log with date
    log.append("\(Date()): \(message)\n")
    // the do catch block is necessary for every function needing to write to disk
    do {
           try log.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
       } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            print("Failed to write to log: \(error.localizedDescription)")
       }
}
challenge28b("log.txt", message: "Log")
```
