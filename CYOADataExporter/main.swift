//
//  main.swift
//  CYOADataExporter
//
//  Created by Russell Gordon on 2024-06-02.
//

import Foundation
import Cocoa

print("Hello, World!")

var insertStatements = ""

for node in storyNodes {
    
    let nodeText = node.paragraphs.joined(separator: "\n\n").replacingOccurrences(of: "'", with: "''")
    
    insertStatements += "INSERT INTO node (id, narrative, image) VALUES (\(node.id), '\(nodeText)', \(node.image == nil ? "NULL" : "'\(node.image!)'"));\n"
    insertStatements += "\n"
}

// Print the output
print(insertStatements)

// Copy to the clipboard
print("About to add to clipboard...", terminator: "")
let pasteBoard = NSPasteboard.general
pasteBoard.clearContents()
pasteBoard.setString(insertStatements, forType: .string)
print("done.")


