//
//  RecipeViewController.swift
//  Meal Snap
//
//  Created by Sam Gustafsson on 5/1/21.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var restrictions: UITextField!
    @IBOutlet weak var foodCatagory: UITextField!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var foodInstructions: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
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
