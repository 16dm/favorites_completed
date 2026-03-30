//
// FavoritesView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favorites: FavoritesViewModel

    var body: some View {
        NavigationStack {
            List {
                if !favorites.cities.filter(\.isFavorite).isEmpty {
                    Section(header: Text("Cities")) {
                        ForEach(favorites.cities.filter(\.isFavorite)) { city in
                            HStack {
                                Text(city.cityName)
                                    .font(.body)
                                Spacer()
                                Button(action: {
                                    favorites.toggleFavoriteCity(city: city)
                                }) {
                                    Image(systemName: city.isFavorite ? "heart.fill" : "heart")
                                        .foregroundStyle(city.isFavorite ? .red : .gray)
                                }
                            }
                        }
                    }
                }

                if !favorites.hobbies.filter(\.isFavorite).isEmpty {
                    Section(header: Text("Hobbies")) {
                        ForEach(favorites.hobbies.filter(\.isFavorite)) { hobby in
                            HobbyRowView(hobby: hobby)
                        }
                    }
                }

                if !favorites.books.filter(\.isFavorite).isEmpty {
                    Section(header: Text("Books")) {
                        ForEach(favorites.books.filter(\.isFavorite)) { book in
                            BookRowView(book: book)
                        }
                    }
                }

                if favorites.cities.allSatisfy({ !$0.isFavorite }) &&
                    favorites.hobbies.allSatisfy({ !$0.isFavorite }) &&
                    favorites.books.allSatisfy({ !$0.isFavorite }) {
                    Text("No favorites yet!")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                if favorites.cities.contains(where: \.isFavorite) ||
                    favorites.hobbies.contains(where: \.isFavorite) ||
                    favorites.books.contains(where: \.isFavorite) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Clear All") {
                            favorites.clearAllFavorites()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
