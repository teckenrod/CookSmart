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

        ingredientTableView.dataSource = self
        instructionTableView.dataSource = self
        
        ingredientTableView.register(UINib(nibName: K.Misc.IngredientCellIndentifier, bundle: nil), forCellReuseIdentifier: K.Misc.IngredientCellIndentifier)
        instructionTableView.register(UINib(nibName: K.Misc.InstructionCellIdentifier, bundle: nil), forCellReuseIdentifier: K.Misc.InstructionCellIdentifier)
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
        ingredientAmountTextField.text = ""
        ingredientUnitDropDown.setTitle("Cup", for: .normal)
        
        // add ingredient to text view
        DispatchQueue.main.async {
            self.ingredientTableView.reloadData()
        }
    }
    
    @IBAction func addInstruction(_ sender: UIButton) {
        // get instruction info
        let instruction = instructionTextField.text!
        
        // reset instruction input
        instructionTextField.text = ""
        
        // add instruction to text view
        DispatchQueue.main.async {
            self.instructionTableView.reloadData()
        }
    }
    
    @IBAction func saveRecipe(_ sender: UIButton) {
    }
    
}

//MARK: - UITableViewDataSource
extension AddRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnVal = 0
        if tableView == ingredientTableView {
            returnVal = ingredients.count
        } else if  tableView == instructionTableView {
            returnVal = instructions.count
        }
        return returnVal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        if tableView == ingredientTableView {
            let returnCell = tableView.dequeueReusableCell(withIdentifier: K.Misc.IngredientCellIndentifier, for: indexPath) as! IngredientTableViewCell
            returnCell.ingredientLabel.text = ingredients[indexPath.row].item
            returnCell.amountLabel.text = String(ingredients[indexPath.row].amount)
        } else if  tableView == instructionTableView {
            let returnCell = tableView.dequeueReusableCell(withIdentifier: K.Misc.InstructionCellIdentifier, for: indexPath) as! InstructionTableViewCell
            returnCell.instructionLabel.text = instructions[indexPath.row]
            returnCell.instructionNumLabel.text = String(instructions.count)
        }
        return returnCell
    }
}
