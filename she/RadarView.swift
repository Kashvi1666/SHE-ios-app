//  Created by Kashvi on 8/16/23.

import Foundation
import SwiftUI

struct ToDoItem: Identifiable {
    var id = UUID()
    var name: String
}

struct RadarView: View {
    @State private var toDoItems: [ToDoItem] = []
    @State private var newItemName: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background").ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("To-Do List")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding()

                    HStack {
                        TextField("Enter new item", text: $newItemName)
                            .padding(10)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)

                        Button(action: {
                            if newItemName.trimmingCharacters(in: .whitespaces) != "" {
                                toDoItems.append(ToDoItem(name: newItemName))
                                newItemName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .padding(.leading, 10)
                        }
                    }

                    List {
                        ForEach(toDoItems) { item in
                            Text(item.name)
                        }
                        .onDelete(perform: removeItems)
                    }
                    .padding()
                }
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        toDoItems.remove(atOffsets: offsets)
    }
}

struct RadarView_Previews: PreviewProvider {
    static var previews: some View {
        RadarView()
    }
}
