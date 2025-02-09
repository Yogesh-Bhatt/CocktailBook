//
//  Untitled.swift
//  CocktailBook
//
//  Created by Yogesh Bhatt on 09/02/25.
//

import Foundation

struct Cocktail: Identifiable, Codable {
    let id: String
    let name: String
    let category: String
    let instructions: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case imageURL = "strDrinkThumb"
    }
}
