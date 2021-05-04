//
//  PostUploadViewController.swift
//  Meal Snap
//
//  Created by Sam Gustafsson on 5/4/21.
//

import UIKit
import AlamofireImage
import Parse

class PostUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var captionLabel: UITextField!
    
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var restrictions: UITextField!
    @IBOutlet weak var foodCategory: UITextField!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var foodInstructions: UITextView!
    
    @IBOutlet weak var addRecipeButton: UIButton!{
        didSet{
            addRecipeButton.layer.cornerRadius = 10
            addRecipeButton.layer.borderWidth = 2
            addRecipeButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.becomeFirstResponder()
        restrictions.becomeFirstResponder()
        foodCategory.becomeFirstResponder()
        ingredients.becomeFirstResponder()
        foodInstructions.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onShareButton(_ sender: Any) {
        let post = PFObject(className: "Recipe")
        
        post["postTitle"] = postTitle.text!
        post["caption"] = captionLabel.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("Error!")
            }
        }
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        let recipe = PFObject(className: "Recipe")
        
        recipe["recipeTitle"] = recipeTitle.text!
        recipe["restriction"] = restrictions.text!
        recipe["category"] = foodCategory.text!
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
