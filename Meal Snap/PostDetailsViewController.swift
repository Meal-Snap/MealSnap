//
//  PostDetailsViewController.swift
//  Meal Snap
//
//  Created by Farhene Sultana on 4/24/21.
//

import UIKit
import Parse
import AlamofireImage

class PostDetailsViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject!
    var user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        usernameLabel.text = user.username
        postNameLabel.text = post["postTitle"] as? String
        captionLabel.text = post["caption"] as? String
        
        //userImage = post["userpic"] as! PFFileObject
        
        //converting file to image from Parse
        if let imageFile = post["image"] as? PFFileObject{
            let imageUrlString = imageFile.url!
            let imageURL = URL(string: imageUrlString)!
            
            //Use alamofireimage for user profile pic
            imagePost.af.setImage(withURL: imageURL)
        }
        if let userimageFile = post["author.userpic"] as? PFFileObject{
            let userimageUrlString = userimageFile.url!
            let userimageURL = URL(string: userimageUrlString)!
            
            //Use alamofireimage for user profile pic
            userImage.af.setImage(withURL: userimageURL)
        }
        
    }
    
    @IBOutlet weak var recipeButton: UIButton!{
        didSet{
            recipeButton.layer.cornerRadius = 10
            recipeButton.layer.borderWidth = 2
            recipeButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // I need a segue function here to pass on the post's AUTHOR!!!
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let next = segue.destination as? RecipeDetailsViewController
        
        //let imageFile = imageView.image!.pngData()
        //let file = PFFileObject(data: imageFile!)
        
        //next?.post["image"] = file
        //next?.post["postTitle"] = titleLabel.text!
        //next?.post["caption"] = descriptionLabel.text!
       // next?.user = post["author"]
        next?.recipe = post
    }
}
