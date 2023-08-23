//
//  CookBookTableViewController.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/3/23.
//

import UIKit
import Firebase

class CookBookTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: K.Misc.RecipeCellIdentifier, bundle: nil), forCellReuseIdentifier: K.Misc.RecipeCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadRecipes()
    }
    
    func loadRecipes() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.typeField).addSnapshotListener { (querySnapshot, error) in
            self.recipes = []
            
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        let data = doc.data()
                        if let recipeName = data[K.FStore.nameField] as? String,
                           let recipeUser = data[K.FStore.userField] as? String,
                           let recipeTime = data[K.FStore.timeField] as? Int,
                           let recipeIngredients = data[K.FStore.ingredientsField] as? [String],
                           let recipeInstructions = data[K.FStore.instructionField] as? [String],
                           let recipeType = data[K.FStore.typeField] as? String,
                           let recipeServings = data[K.FStore.servingsField] as? Int
                        {
                            var ings: [Ingredient] = []
                            for recipe in recipeIngredients {
                                let recipeArr = recipe.split(separator: ",")
                                ings.append(Ingredient(item: String(recipeArr[0]), amount: Double(recipeArr[1].replacing(" ", with: ""))!, unit: String(recipeArr[2])))
                            }
                            let newRecipe = Recipe(recipeName: recipeName, user: recipeUser, timeMins: recipeTime, ingredients: ings, instructions: recipeInstructions, mealType: recipeType, servings: recipeServings, allergens: [], ID: doc.documentID)
                            self.recipes.append(newRecipe)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Misc.RecipeCellIdentifier, for: indexPath) as! RecipeTableViewCell
        cell.recipeTitle.text = recipe.recipeName
        cell.timeLabel.text = "\(recipe.timeMins) min(s)"
        cell.servingsLabel.text = String(recipe.servings)
        cell.mealTypeLabel.text = recipe.mealType
        // cell.mealImageView.image = image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segues.toRecipe, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.toRecipe,
           let next = segue.destination as? RecipeViewController,
           let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedRecipe = recipes[indexPath.row]
            next.currentRecipe = selectedRecipe
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
