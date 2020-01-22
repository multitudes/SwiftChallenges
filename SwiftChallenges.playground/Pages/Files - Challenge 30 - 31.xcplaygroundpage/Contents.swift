/*:
 [Previous](@previous)

 # Challenge 30: New JPEGs
 ## Difficulty: Easy

Write a function that accepts a path to a directory and returns an array of all JPEGs that have been created in the last 48 hours.

 Tip #1: For the purpose of this task, just looking for “.jpg” and “.jpeg” file extensions is sufficient.

 Tip #2: For this challenge, assume time is regular and constant, i.e. the user has not changed their timezone or moved into or out from daylight savings.

 Tip #3: Use the terminal command touch -t YYYYMMDDHHMM somefile.jpg to adjust the creation time of a file, e.g. touch -t 201612250101.

 ### Sample input and output
 
• If your directory contains three JPEGs older than 48 hours and three newer, your function should return the names of the three newer.
 
 [Next](@next)
*/

import Foundation

// create some files
FileManager.default.createFile(atPath: "/Users/laurentb/Documents/test.jpeg", contents: nil)
FileManager.default.createFile(atPath: "/Users/laurentb/Documents/test1.jpeg", contents: nil)
// created and then changed in terminal with touch -t 201612250101 /Users/laurentb/Documents/testOld.jpeg
//FileManager.default.createFile(atPath: "/Users/laurentb/Documents/testOld.jpeg", contents: nil)

func challenge30(in directory: String) {
    
    let files = (try? FileManager.default.contentsOfDirectory(atPath: "/Users/laurentb/Documents/")) ?? []
//    files.filter() { $0.pathExtension == "jpeg" }
    
    
    let attributes = ( try? FileManager.default.attributesOfItem(atPath: "/Users/laurentb/Documents/")) ?? [:]
    print(files, attributes[FileAttributeKey.creationDate])
    guard let creationDate = attributes[.creationDate] as? Date else { print(" doh") ; return }
    print(creationDate)
    if creationDate > Date(timeIntervalSinceNow: -60 * 60 * 48) {
        print("yes")
    }
    
}
challenge30(in: "/Users/laurentb/Documents/")

func challenge30a(in directory: String) -> [String] {
    
    // fine distinction here. there are two methods contentsOfDirectory. one returns strings contentsOfDirectory(atPath:) , the other urls.
    // to get the urls you need to pass a url! to contentsOfDirectory(at: includingPropertiesForKeys:)
    let directoryURL = URL(fileURLWithPath: directory)
    guard let files = try? FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil ) else { return []}
    var jpegs = [String]()
    
    for file in files {
        if file.pathExtension == "jpg" || file.pathExtension == "jpeg"  {
            print("file.path \(file.path)")
            // every url will have a dict with attributes. need to get the attribute with file.path
            guard let attribute = try? FileManager.default.attributesOfItem(atPath: file.path) else { continue }
            guard let creation = attribute[.creationDate] as? Date else { continue }
            print(creation)
            if creation > Date(timeIntervalSinceNow: -60*60*48) {
                jpegs.append(file.lastPathComponent)
            }
        }
    }
    
    return jpegs
}
challenge30a(in: "/Users/laurentb/Documents/")
 
/*:
 [Previous](@previous)

 # Challenge 31: Copy recursively
 ## Difficulty: Easy

Write a function that accepts two paths: the first should point to a directory to copy, and the second should be where the directory should be copied to. Return true if the directory and all its contents were copied successfully; false if the copy failed, or the user specified something other than a directory.

 
 ### Sample input and output
 
 • If your directory exists and is readable, the destination is writeable, and the copy succeeded, your function should return true.
 
 • Under all other circumstances you should return false: if the directory does not exist or was not readable, if the destination was not writeable, if a file was specified rather than a directory, or if the copy failed for any other reason.
 
 [Next](@next)
*/
func challenge31(source: String, destination: String) -> Bool {
    var isDirectory: ObjCBool = false
    // the first part of my guard will check wether the file in source exists and it it is a dir
    print(FileManager.default.fileExists(atPath: source, isDirectory: &isDirectory))
    print("\n",isDirectory)
    guard FileManager.default.fileExists(atPath: source, isDirectory: &isDirectory) && isDirectory.boolValue == true
        else {
        print("file is not dir or not exists")
        return false
    }
    let sourceURL = URL(fileURLWithPath: source)
    // I need to append the folder for the destination! otherwise I will have an error message
    let destinationURL = URL(fileURLWithPath: destination).appendingPathComponent(sourceURL.lastPathComponent)
    print("source \(sourceURL), dest: \(destinationURL)")
    do {
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
    } catch {
        print("Copy failed: \(error.localizedDescription)")
        return false
    }
    return true
}
challenge31(source: "/Users/laurentb/Documents/testss", destination: "/Users/laurentb/")
