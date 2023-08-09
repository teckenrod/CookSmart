//
//  Recipe.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/4/23.
//

import Foundation

struct Recipe {
    let recipeName: String
    let user: String
    let timeMins: Int
    let ingredients: [Ingredient]
    let instructions: [String]
    let mealType: String
    let servings: Int
    let allergens: [String]
}
