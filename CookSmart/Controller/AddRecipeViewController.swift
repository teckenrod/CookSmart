//
//  AddRecipeViewController.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/4/23.
//

import UIKit

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var timeHrsDropDown: UIButton!
    @IBOutlet weak var timeMinsDropDown: UIButton!
    @IBOutlet weak var mealTypeDropDown: UIButton!
    @IBOutlet weak var servingsDropDown: UIButton!
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientAmountDropDown: UIButton!
    @IBOutlet weak var ingredientUnitDropDown: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    @IBOutlet weak var instructionTextField: UITextField!
    
    @IBOutlet weak var instructionTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
    }
    
    @IBAction func addInstruction(_ sender: UIButton) {
    }
}
