//
//  RecipeViewController.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/3/23.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var currentRecipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentRecipe != nil {
            // simple labels
            recipeNameLabel.text = currentRecipe?.recipeName
            userNameLabel.text = currentRecipe?.user
            timeLabel.text = "\(currentRecipe!.timeMins)"
            servingsLabel.text = "\(currentRecipe!.servings)"
            typeLabel.text = currentRecipe?.mealType
            
            // ingredients
            var ingredientsLabelText = ""
            for ing in currentRecipe!.ingredients {
                ingredientsLabelText.append("\(ing.item) \(ing.amount) \(ing.unit)  \n")
            }
            ingredientsLabel.text = ingredientsLabelText
            ingredientsLabel.numberOfLines = 0
            
            // instructions
            var instructionsLabelText = ""
            for i in 0..<currentRecipe!.instructions.count {
                instructionsLabelText.append("\(i+1). \(currentRecipe!.instructions[i])  \n")
            }
            instructionsLabel.text = instructionsLabelText
            instructionsLabel.numberOfLines = 0
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
