//
//  Untitled.swift
//  CocktailBook
//
//  Created by Yogesh Bhatt on 09/02/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    
    func fetchCocktails(query: String, completion: @escaping ([Cocktail]) -> Void) {
        guard let url = URL(string: baseURL + query) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.drinks ?? [])
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}

struct CocktailResponse: Codable {
    let drinks: [Cocktail]?
}
