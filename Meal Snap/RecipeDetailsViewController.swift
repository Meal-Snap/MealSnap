//
//  RecipeDetailsViewController.swift
//  Meal Snap
//
//  Created by Farhene Sultana on 5/6/21.
//

import UIKit
import Parse

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var foodRestrictions: UILabel!
    @IBOutlet weak var foodCategory: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var instructions: UILabel!
    
    var recipe = PFObject(className: "Recipe")
    //var user = PFUser()
    //var recipe = PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        recipeTitle.text = recipe["recipeTitle"] as? String
        foodRestrictions.text = recipe["restrictions"] as? String
        foodCategory.text = recipe["category"] as? String
        ingredients.text = recipe["ingredients"] as? String
        instructions.text = recipe["instructions"] as? String
    }
}
