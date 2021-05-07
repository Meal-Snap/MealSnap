//
//  RecipeUploadViewController.swift
//  Meal Snap
//
//  Created by Farhene Sultana on 5/6/21.
//

import UIKit
import Parse

class RecipeUploadViewController: UIViewController {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var restrictions: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var instructions: UITextView!
    
    let post = PFObject(className: "Recipe")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onShareButton(_ sender: Any) {
        post["author"] = PFUser.current()!
        post["recipeTitle"] = recipeTitle.text!
        post["restriction"] = restrictions.text!
        post["category"] = category.text!
        post["ingredients"] = ingredients.text!
        post["instructions"] = instructions.text!
                
        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("Error!")
            }
        }
    }
    

}
