//
//  Item.swift
//  ToDoApp
//
//  Created by Per-Arne Johansson on 2024-11-11.
//

import Foundation
import SwiftData

/// The `Item` model represents a single to-do item with text, a timestamp, and a completion status.
/// This model conforms to `Identifiable` to allow easy use within SwiftUI lists and supports SwiftData for persistence.
@Model
final class Item: Identifiable {
    /// The main text or description of the to-do item.
    var text: String
    
    /// The date and time when the item was created or added.
    var timestamp: Date
    
    /// A Boolean flag indicating whether the item is marked as completed. Defaults to `false`.
    var isCompleted: Bool = false
    
    /// Initializes a new `Item` instance with the provided text and timestamp.
    ///
    /// - Parameters:
    ///   - text: The main description or content of the to-do item.
    ///   - timestamp: The creation date and time of the item.
    init(text: String, timestamp: Date) {
        self.text = text
        self.timestamp = timestamp
    }
}



