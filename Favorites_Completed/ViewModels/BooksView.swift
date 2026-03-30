//
// BooksView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.

import SwiftUI

struct BooksView: View {
    @Binding var searchText: String
    @EnvironmentObject private var favorites: FavoritesViewModel

    var body: some View {
        List {
            ForEach(favorites.filteredBooks(searchText: searchText)) { book in
                BookRowView(book: book)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    BooksView(searchText: .constant(""))
        .environmentObject(FavoritesViewModel())
}
