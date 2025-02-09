//
//  Untitled.swift
//  CocktailBook
//
//  Created by Yogesh Bhatt on 09/02/25.
//

import Foundation

class CocktailViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var favorites: Set<String> = []
    
    init() {
       // loadFavorites()
        //fetchCocktails()
    }
    
    func fetchCocktails(query: String) {
        APIService.shared.fetchCocktails(query: query) { [weak self] drinks in
            self?.cocktails = drinks
        }
    }
    
    func toggleFavorite(cocktail: Cocktail) {
        if favorites.contains(cocktail.id) {
            favorites.remove(cocktail.id)
        } else {
            favorites.insert(cocktail.id)
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: "FavoriteCocktails")
    }
    
    private func loadFavorites() {
        favorites = Set(UserDefaults.standard.stringArray(forKey: "FavoriteCocktails") ?? [])
    }
}
