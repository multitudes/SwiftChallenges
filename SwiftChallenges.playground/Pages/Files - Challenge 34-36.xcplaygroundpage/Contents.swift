/*:
 [Previous](@previous)

 # Challenge 34: Find executables
 ### Difficulty: Tricky

Write a function that accepts the name of a directory to scan, and returns an array containing
the name of any executable files in there.

 Sample input and output

 • If directory/a exists and is executable, “a” should be in the array you return.
 
• If directory/subdirectory/a exists and is executable, it should not be in the array you
 
return; only return files in the directory itself, not its subdirectories.
 
• If there are no executable files, return an empty array.
 
 #### Hints

 Hint #1: Make sure you create the test directories as shown in the sample input/output. You can use touch a to create a file called “a”, then chmod a+x a to mark it executable.
 
Hint #2: You probably want to use the isExecutableFile() method of FileManager. Hint #3: If you don’t create at least one subdirectory to test with, your tests will be
incomplete.
 
Hint #4: Directories are considered executable for historical reasons. If they appear in your return array, you won’t have passed the challenge.
 
 [Next](@next)
*/
import Foundation


//Working with filesystems is always replete with gotchas, FileManager considers directories to be executable!
//The reason for this is historical: file permissions mean one thing when they are attached to files, and something else entirely when attached to directories. For files, executable permission means the file can be run, so it’s a script or a binary. However, for directories executable permission means the user can enter into the directory and access its contents.

func challenge34a(directory: String) -> [String] {

    let directoryURL = URL(fileURLWithPath: directory)
    guard let files = try? FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)  else {
        return []
    }
    var executables = [String]()
    for file in files {
        print(file)
        // this is better
        guard file.hasDirectoryPath == false else { continue }
        //guard FileManager.default.fileExists(atPath: file.path, isDirectory: &isDirectory) && isDirectory.boolValue == false else {continue}
        if FileManager.default.isExecutableFile(atPath: file.path) {
            executables.append(file.lastPathComponent)
        }
            else { continue }

    }
    
    return executables
}

challenge34a(directory: "/Users/laurentb/Documents/testss/a")


/*:
 [Previous](@previous)

 # Challenge 35: Convert images
 
 ### Difficulty: Tricky
 
 Write a function that accepts a path to a directory, then converts to PNGs any JPEGs it finds in there, leaving the originals intact. If any JPEG can’t be converted the function should just quietly continue.
 
 Tip #1: For the purpose of this task, just looking for “.jpg” and “.jpeg” file extensions is sufficient.
 
 Tip #2: You can write this for iOS or macOS depending on your skills. iOS is easy to code but tricky to create a test environment for, and macOS is the opposite. If you can solve this on both platforms, I’d rate this Taxing.
 
 #### Sample input and output
 
 • If your directory exists and is readable, all JPEGs in there should be converted to PNGs.
 
 • If any JPEGs can’t be read, converted, or written, just continue on quietly.

 
 #### Hints

 Hint #1: If you’re solving this on iOS, you will need to use UIImage(contentsOfFile:) and UIImagePNGRepresentation().
 
 Hint #2: If you’re solving this on macOS, you will need to use NSImage and NSBitmapImageRep.
 
 Hint #3: Make sure and check the pathExtension property for each file.
 
 Hint #4: Calling write() on a Data instance throws an exception if things go wrong, but the challenge wants you to ignore it and carry on – a perfect use for try?, but make sure you silence the warning.
 
 [Next](@next)
*/
// start for iOS ..? cant change settings of the playground so I just will import UIKit? nope! ;)
 
import AppKit

func challenge35(in directory: String) {

    let directoryURL = URL(fileURLWithPath: directory)
    guard let files = try? FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil) else {
        return
    }
    for file in files {
        guard file.pathExtension == "jpg" || file.pathExtension == "jpeg" else { continue }
        print(file.lastPathComponent)
        // this is for ios!
//        guard let image = UIImage(contentsOfFile: file.path) else
//        { continue }
//        guard let png = UIImagePNGRepresentation(image) else
//        { continue }
// in macos
        //you can create an NSImage in a similar way to a UIImage (macOS even has a URL-based initializer, which is a bonus!), but getting that image into PNG data is non-trivial.
        // but there’s only one I consider even vaguely straightforward: get the TIFF representation of the image (this is a property on NSImage), create a bitmap representation from that, then convert that to a PNG for writing.
        
        guard let image = NSImage(contentsOf: file) else { continue }
        //print(image)
        guard let tiffData = image.tiffRepresentation else { continue }
        guard let imageRep = NSBitmapImageRep(data: tiffData) else { continue }
        guard let png = imageRep.representation(using: .png, properties: [:]) else { continue }
        
        let newFilename = file.deletingPathExtension().appendingPathExtension("png")
        try? png.write(to: newFilename)
    }
}

challenge35(in: "/Users/laurentb/Documents/test")



/*:
 [Previous](@previous)

 # Challenge 36: Print error lines
 
 ### Difficulty: Taxing
 
 Write a function that accepts accepts a path to a log file on disk, and returns how many lines
 start with “[ERROR]”. The log file could be as large as 10GB, but may also not exist.
 
 #### Sample input and output
 
 • If the file contains 100,000,000 lines and eight start with “[ERROR]” your function should return 8.
 
 • If the file does not exist, cannot be loaded, or contains zero lines starting with “[ERROR]” your function should return 0.

 #### Hints

 Hint #1: You can use the contentsOfFile initializer for strings, but only if you want to be laughed out of the room.

 Hint #2: This is a job for FileHandle, which opens a file and reads chunks of a size you specify using readData(ofLength:).

 Hint #3: FileHandle doesn’t care about line breaks, so it will read as much data as you ask. It’s down to you to use range(of:) to find zero or more line breaks inside the chunk you read.

 Hint #4: To make things neater, I created a custom class to store my file reading code – you might want to consider doing the same.

 [Next](@next)
*/

/*:
 ## solution
 
 This is a challenge that ought to be easy, but sadly is far harder than you think because Swift doesn’t have any neat APIs for streaming data
 Here’s how the code works:
 1. It’s a new class called ChunkedFileReader that is responsible for opening a file and reading lines until the end of the file is reached.
 2. I’ve made it read lines 4 characters at a time (chunkSize), which is an absurdly small amount in production, but great as a test so you can step through it at runtime to see how it works. (A chunk size of between 1024 and 8192 bytes would be more sensible for production.)
 3. You initialize the class by passing it a filename. It then creates a buffer, which is what it reads the file into over time.
 4. Every time you call its readLine() method, it attempts to find the next line break. It does this by reading chunkSize bytes into its buffer and scanning for the delimiter “\n”.
 5. If no line break is found, it keeps reading chunks and placing them into the buffer.
 6. Eventually, either a line break is found or the file ends. Either way, if the buffer has
 data inside it gets converted into a string and sent back.

*/

//Here’s my ChunkedFileReader class, with inline comments:
class ChunkedFileReader {
    var fileHandle: FileHandle?
    // we keep adding to the buffer until eventually we find a line break or hit the end of the file
    var buffer: Data
    // this should be between 1024 and 8192 for production; it determines how much of the file is read in each step
    let chunkSize: Int = 4
    // this determines what we consider to be an end of line
    let delimiter = "\n".data(using: .utf8)!
    
    init(path: String) {
    // open the file handle and prepare the buffer
        fileHandle = FileHandle(forReadingAtPath: path)
        buffer = Data(capacity: chunkSize)
    }
    func readLine() -> String? {
        // find the delimiter in our buffer
        var rangeOfDelimiter = buffer.range(of: delimiter)
        
        // loop until we finally find a delimiter
        while rangeOfDelimiter == nil {
            // try to read a chunk from the file handle, or bail out if it didn't work
            guard let chunk = fileHandle?.readData(ofLength: chunkSize) else { return nil }
            print(chunk)
            if chunk.count == 0 {
                // the chunk was read successfully, but was empty we reached the end of the file
                if buffer.count > 0 {
                    // the buffer has something left in it; send it back, and make sure to clear the buffer's remnants when it's finished
                    defer { buffer.count = 0 }
                    return String(data: buffer, encoding: .utf8)
                }
                // we reached the end of the file and the buffer was empty; send back nil
                return nil
                
            } else {
                // we read some data; append it to our buffer
                buffer.append(chunk)
                print(buffer)
                // now re-scan for the delimiter
                rangeOfDelimiter = buffer.range(of: delimiter)
            }
        }
        // we can only make it here if we found a delimiter, but it might be anywhere inside our buffer; we want to pull out everything in our buffer from the start up to where the delimiter lies
        let rangeOfLine = 0 ..< rangeOfDelimiter!.upperBound
        // convert that range of our buffer into a string
        let line = String(data: buffer.subdata(in: rangeOfLine), encoding: .utf8)
        // then remove it from the buffer
        buffer.removeSubrange(rangeOfLine)
        // send the line back, removing the trailing line break at the end.
        return line?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
    
func challenge36(filename: String) -> Int {
    var totalErrors = 0
    let reader = ChunkedFileReader(path: filename)
    while let line = reader.readLine() {
        print(line)
        if line.hasPrefix("[ERROR]") {
            totalErrors += 1
        }
    }
   return totalErrors
}
challenge36(filename: "/Users/laurentb/Documents/test/output.txt")
