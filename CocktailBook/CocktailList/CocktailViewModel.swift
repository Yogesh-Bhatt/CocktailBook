import SwiftUI
import Combine

protocol CocktailServiceProtocol {
    func fetchCocktails(query: String, completion: @escaping ([Cocktail]) -> Void)
}

class CocktailService: CocktailServiceProtocol {
    func fetchCocktails(query: String, completion: @escaping ([Cocktail]) -> Void) {
        // Actual network call here
        APIService.shared.fetchCocktails(query: query) { [weak self] drinks in
            completion(drinks)
        }

    }
}

class CocktailViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var favorites: Set<String> = []
    private var service: CocktailServiceProtocol
    
    init(service: CocktailServiceProtocol = CocktailService()) {
        self.service = service
    }
    
    func toggleFavorite(cocktail: Cocktail) {
        if favorites.contains(cocktail.id) {
            favorites.remove(cocktail.id)
        } else {
            favorites.insert(cocktail.id)
        }
       // saveFavorites()
    }

    func fetchCocktails(query: String) {
        service.fetchCocktails(query: query) { [weak self] cocktails in
            DispatchQueue.main.async {
                self?.cocktails = cocktails
            }
        }
    }
}
