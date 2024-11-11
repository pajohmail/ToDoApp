import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var newItemText: String = ""

    var body: some View {
        VStack {
            // List of items, sorted to show incomplete items first
            List {
                ForEach(sortedItems) { item in
                    HStack {
                        // Trashcan button to delete the item
                        Button(action: {
                            removeItem(item)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle()) // Prevents button from affecting row selection

                        VStack(alignment: .leading) {
                            Text(item.text) // Displays the item's text
                            Text(item.timestamp, style: .date) // Displays the timestamp
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        // Checkmark icon shown if the item is marked as completed
                        if item.isCompleted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle()) // Makes the entire row tappable
                    .onTapGesture {
                        toggleItemCompletion(item) // Toggles completion status on tap
                    }
                }
            }

            // Bottom bar containing a text field and an "Add Item" button
            HStack {
                TextField("Skriv text", text: $newItemText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: addItem) {
                    Text("Lägg till punkt")
                }
                .padding(.trailing)
            }
            .background(Color(UIColor.systemGray5))
        }
    }

    /// Computed property that sorts items, showing incomplete items first and completed items last.
    private var sortedItems: [Item] {
        items.sorted { !$0.isCompleted && $1.isCompleted }
    }

    /// Adds a new item with the current text and timestamp to the SwiftData model context.
    private func addItem() {
        withAnimation {
            guard !newItemText.isEmpty else { return }
            let newItem = Item(text: newItemText, timestamp: Date())
            modelContext.insert(newItem)
            newItemText = ""
        }
    }

    /// Toggles the completion status of a given item.
    private func toggleItemCompletion(_ item: Item) {
        withAnimation {
            item.isCompleted.toggle()
        }
    }

    /// Removes a given item from the SwiftData model context.
    private func removeItem(_ item: Item) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}





  
               

