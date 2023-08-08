//
//  Constants.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/3/23.
//

import Foundation

struct K {
    struct Segues {
        static let toAccount = "ShowAccount"
        static let toPlan = "ShowPlan"
        static let toCookbook = "ShowCookbook"
        static let toList = "ShowList"
        static let toStats = "ShowStats"
        static let toRecipe = "ShowRecipe"
        static let toPantry = "ShowPantry"
    }
    
    struct Colors {
        static let main = "MainColor"
        static let lightAccent = "LightAccentColor"
        static let darkAccent = "DarkAccentColor"
    }
    
    struct FStore {
        static let collectionName = "recipes"
        static let nameField = "name"
        static let userField = "user"
        static let timeField = "time"
        static let typeField = "type"
        static let servingsField = "servings"
        static let ingredientsField = "ingredients"
        static let instructionField = "instructions"
        static let allergensField = "allergens"
    }
    
    struct AccText {
        static let login = "Login"
        static let register = "Register"
        static let logout = "Log Out"
    }
    
//    struct TimeUnits {
//        static let min = "Min"
//        static let mins = "Mins"
//        static let hour = "Hr"
//        static let hours = "Hrs"
//    }
    
    struct MealTypes {
        static let breakfast = "Breakfast"
        static let meal = "Meal"
        static let snack = "Snack"
        static let dessert = "Dessert"
    }
    
    struct Allergies {
        static let wheat = "Wheat"
        static let eggs = "Eggs"
        static let soy = "Soy"
        static let dairy = "Dairy"
        static let shellfish = "Shellfish"
        static let peanuts = "Peanuts"
        static let nuts = "Nuts"
        static let seeds = "Seeds"
    }
    
    struct Measurements {
        
    }
    
    struct Misc {
        static let RecipeCellIdentifier = "RecipeTableViewCell"
        static let InstructionCellIdentifier = "InstructionTableViewCell"
        static let IngredientCellIndentifier = "IngredientTableViewCell"
    }
}
