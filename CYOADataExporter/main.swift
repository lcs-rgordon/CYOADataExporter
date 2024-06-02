//
//  main.swift
//  CYOADataExporter
//
//  Created by Russell Gordon on 2024-06-02.
//

import Foundation
import Cocoa

print("Hello, World!")

var insertStatementsForNodes = ""
var insertStatementsForEdges = ""

for node in storyNodes {
    
    let nodeText = node.paragraphs.joined(separator: "\n\n").replacingOccurrences(of: "'", with: "''")
    
    var ending_type_id: Int? = nil
    var ending_context: String? = nil
    if let ending = node.ending {
        switch ending.classification {
        case .great:
            ending_type_id = 1
        case .favorable:
            ending_type_id = 2
        case .mediocre:
            ending_type_id = 3
        case .disappointing:
            ending_type_id = 4
        case .catastrophic:
            ending_type_id = 5
        }
        ending_context = ending.description.replacingOccurrences(of: "'", with: "''")
    }
    
    insertStatementsForNodes += "INSERT INTO node (id, narrative, image, ending_type_id, ending_context) VALUES (\(node.id), '\(nodeText)', \(node.image == nil ? "NULL" : "'\(node.image!)'"), \(node.ending == nil ? "NULL" : "\(ending_type_id!)"), \(node.ending == nil ? "NULL": "'\(ending_context!)'"));\n"
    
    insertStatementsForNodes += "\n"
    
    for edge in node.edges {
        insertStatementsForEdges += "INSERT INTO edge (prompt, to_node, from_node) VALUES ('\(edge.prompt.replacingOccurrences(of: "'", with: "''"))', \(edge.destinationId), \(node.id));\n"
        insertStatementsForEdges += "\n"
    }
    
    
}

// Access the clipboard
let pasteBoard = NSPasteboard.general

// Print the output
print(insertStatementsForNodes)

// Copy to the clipboard
print("About to nodes add to clipboard...", terminator: "")
pasteBoard.clearContents()
pasteBoard.setString(insertStatementsForNodes, forType: .string)
print("done.")

print("PRESS RETURN WHEN READY")
let _ = readLine()

// Print the output
print(insertStatementsForEdges)

// Copy to the clipboard
print("About to add edges to clipboard...", terminator: "")
pasteBoard.clearContents()
pasteBoard.setString(insertStatementsForEdges, forType: .string)
print("done.")

