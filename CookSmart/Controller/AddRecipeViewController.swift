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
    var allergens: [String] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set data sources
        ingredientTableView.dataSource = self
        instructionTableView.dataSource = self
        
        // register nibs
        ingredientTableView.register(UINib(nibName: K.Misc.IngredientCellIndentifier, bundle: nil), forCellReuseIdentifier: K.Misc.IngredientCellIndentifier)
        instructionTableView.register(UINib(nibName: K.Misc.InstructionCellIdentifier, bundle: nil), forCellReuseIdentifier: K.Misc.InstructionCellIdentifier)
        
        setUpPopUpButtons()
    }
    
    func setUpPopUpButtons() {
        let popUpButtonClosure = { (action: UIAction) in
            // print("Pop-up action")
        }
        
        // time hrs pop up button
        timeHrsDropDown.showsMenuAsPrimaryAction = true
        var timeHrsOptions: [UIAction] = []
        for i in 0...12 {
            timeHrsOptions.append(UIAction(title: String(i), handler: popUpButtonClosure))
        }
        timeHrsDropDown.menu = UIMenu(children: timeHrsOptions)
        
        // time mins pop up button
        timeMinsDropDown.showsMenuAsPrimaryAction = true
        var timeMinsOptions: [UIAction] = []
        for i in 0...11 {
            timeMinsOptions.append(UIAction(title: String(i*5), handler: popUpButtonClosure))
        }
        timeMinsDropDown.menu = UIMenu(children: timeMinsOptions)
        
        // meal type pop up button
        mealTypeDropDown.showsMenuAsPrimaryAction = true
        mealTypeDropDown.menu = UIMenu(children: [
            UIAction(title: "Breakfast", handler: popUpButtonClosure),
            UIAction(title: "Meal", handler: popUpButtonClosure),
            UIAction(title: "Snack", handler: popUpButtonClosure),
            UIAction(title: "Dessert", handler: popUpButtonClosure),
            UIAction(title: "Sauce", handler: popUpButtonClosure)
        ])
        
        // servings pop up button
        servingsDropDown.showsMenuAsPrimaryAction = true
        var servingsOptions: [UIAction] = []
        for i in 1...12 {
            servingsOptions.append(UIAction(title: String(i), handler: popUpButtonClosure))
        }
        servingsDropDown.menu = UIMenu(children: servingsOptions)
        
        // ingredient unit pop up button
        ingredientUnitDropDown.showsMenuAsPrimaryAction = true
        ingredientUnitDropDown.menu = UIMenu(children: [
            UIAction(title: "C", handler: popUpButtonClosure),
            UIAction(title: "Oz", handler: popUpButtonClosure),
            UIAction(title: "Fl Oz", handler: popUpButtonClosure),
            UIAction(title: "tsp", handler: popUpButtonClosure),
            UIAction(title: "Tbsp", handler: popUpButtonClosure),
            UIAction(title: "g", handler: popUpButtonClosure)
        ])
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
        // get ingredient info
        let item = ingredientTextField.text!
        let amount = Double(ingredientAmountTextField.text!)!
        let unit = (ingredientUnitDropDown.titleLabel?.text!)!
        
        // create ingredient item and append
        let ing = Ingredient(item: item, amount: amount, unit: unit)
        ingredients.append(ing)
        
        // reset ingredient input
        ingredientTextField.text = ""
        ingredientAmountTextField.text = ""
        ingredientUnitDropDown.setTitle("C", for: .normal)
        
        // add ingredient to text view
        DispatchQueue.main.async {
            self.ingredientTableView.reloadData()
        }
    }
    
    @IBAction func addInstruction(_ sender: UIButton) {
        // get instruction info
        let instruction = instructionTextField.text!
        
        // append instruction
        instructions.append(instruction)
        
        // reset instruction input
        instructionTextField.text = ""
        
        // add instruction to text view
        DispatchQueue.main.async {
            self.instructionTableView.reloadData()
        }
    }
    
    @IBAction func saveRecipe(_ sender: UIButton) {
        var ing: [String] = []
        for i in ingredients {
            ing.append("\(i.item) \(i.amount) \(i.unit)")
        }
        let doc: [String: Any] = [
            K.FStore.nameField: recipeNameTextField.text!,
            K.FStore.userField: (Auth.auth().currentUser?.email!)!,
            K.FStore.timeField: Int((timeHrsDropDown.titleLabel?.text!)!)! * 60 + Int((timeMinsDropDown.titleLabel?.text!)!)!,
            K.FStore.typeField: (mealTypeDropDown.titleLabel?.text!)!,
            K.FStore.servingsField: Int((servingsDropDown.titleLabel?.text!)!)!,
            K.FStore.ingredientsField: ing,
            K.FStore.instructionField: instructions,
            K.FStore.allergensField: allergens
        ]
        
        db.collection(K.FStore.collectionName).addDocument(data: doc) { err in
            if let e = err {
                print(e.localizedDescription)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

//MARK: - UITableViewDataSource
extension AddRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(tableView) {
        case ingredientTableView:
            return ingredients.count
        case instructionTableView:
            return instructions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cell: \(indexPath.row)")
        switch(tableView) {
        case ingredientTableView:
            print("Ingredient Table View")
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Misc.IngredientCellIndentifier, for: indexPath) as! IngredientTableViewCell
            cell.ingredientLabel?.text = ingredients[indexPath.row].item
            cell.amountLabel?.text = "\(ingredients[indexPath.row].amount) \(ingredients[indexPath.row].unit)"
            return cell
        case instructionTableView:
            print("Instruction Table View")
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Misc.InstructionCellIdentifier, for: indexPath) as! InstructionTableViewCell
            cell.instructionLabel?.text = instructions[indexPath.row]
            cell.instructionNumLabel?.text = String(indexPath.row + 1)
            return cell
        default:
            print("No Table View")
            return UITableViewCell()
        }
    }
}
