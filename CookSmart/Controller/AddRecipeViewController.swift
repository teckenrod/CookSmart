//
//  AddRecipeViewController.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/4/23.
//

import UIKit
import Firebase

class AddRecipeViewController: UIViewController {

    // name
    @IBOutlet weak var recipeNameTextField: UITextField!
    
    // time
    @IBOutlet weak var timeHrsDropDown: UIButton!
    @IBOutlet weak var timeMinsDropDown: UIButton!
    
    // meal type
    @IBOutlet weak var mealTypeDropDown: UIButton!
    
    // servings
    @IBOutlet weak var servingsDropDown: UIButton!
    
    // ingredients
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientUnitDropDown: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientAmountTextField: UITextField!
    
    // instructions
    @IBOutlet weak var instructionTextField: UITextField!
    @IBOutlet weak var instructionTableView: UITableView!
    
    let user = Auth.auth().currentUser
    var ingredients: [Ingredient] = []
    var instructions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
        // get ingredient info
        let item = ingredientTextField.text!
        let amount = Double(ingredientTextField.text!)!
        let unit = (ingredientUnitDropDown.titleLabel?.text!)!
        
        // create ingredient item and append
        let ing = Ingredient(item: item, amount: amount, unit: unit)
        ingredients.append(ing)
        
        // reset ingredient input
        ingredientTextField.text = ""
        ingredientTextField.text = ""
        ingredientUnitDropDown.setTitle("Cup", for: .normal)
        
        // add ingredient to text view
    }
    
    @IBAction func addInstruction(_ sender: UIButton) {
        // get instruction info
        
        // create instruction item
        
        // reset instruction input
        
        // add instruction to text view
    }
    
    @IBAction func saveRecipe(_ sender: UIButton) {
    }
    
}
