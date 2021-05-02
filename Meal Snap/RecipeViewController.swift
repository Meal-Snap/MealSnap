//
//  RecipeViewController.swift
//  Meal Snap
//
//  Created by Sam Gustafsson on 5/1/21.
//

import UIKit
import Parse

class RecipeViewController: UIViewController {
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var restrictions: UITextField!
    @IBOutlet weak var foodCatagory: UITextField!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var foodInstructions: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.becomeFirstResponder()
        restrictions.becomeFirstResponder()
        foodCatagory.becomeFirstResponder()
        ingredients.becomeFirstResponder()
        foodInstructions.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        let recipe = PFObject(className: "Recipe")
        
        recipe["title"] = recipeTitle.text!
        recipe["restriction"] = restrictions.text!
        recipe["category"] = foodCatagory.text!
        recipe["ingredients"] = ingredients.text!
        recipe["instructions"] = foodInstructions.text!
        
        recipe.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("Error!")
            }
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
