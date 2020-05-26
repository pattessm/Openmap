//
//  SearchBar.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/23/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

// A swiftui version of the uisearchbar, without all the extra cruft
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
            TextField("Search the maps...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(red: 101.0 / 255.0, green: 195.0 / 255.0, blue: 102 / 255.0, opacity: 0.1))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        // To look more like the uikit search bar
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 4)
                 
                        // reset the text if user press the multiply icon
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            // if editing, clear text, drop keyboard, and animate the cancel button away
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
