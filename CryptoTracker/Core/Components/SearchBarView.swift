//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/19/24.
//

import SwiftUI
 
// Reusable search bar
struct SearchBarView: View {

    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .keyboardType(.alphabet)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding() // add padding to increase tappable area
                        .offset(x: 10) // push to the right to offset added padding
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}
