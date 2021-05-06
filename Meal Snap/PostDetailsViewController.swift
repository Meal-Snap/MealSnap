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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        usernameLabel.text = post["username"] as? String
        postNameLabel.text = post["title"] as? String//we need to add title in our Posts class
        captionLabel.text = post["caption"] as? String
        
        //userImage = post["userpic"] as! PFFileObject
        
        //converting file to image from Parse
        if let imageFile = post["image"] as? PFFileObject{
            let imageUrlString = imageFile.url!
            let imageURL = URL(string: imageUrlString)!
            
            //Use alamofireimage for user profile pic
            imagePost.af.setImage(withURL: imageURL)
        }
        if let userimageFile = post["userpic"] as? PFFileObject{
            let userimageUrlString = userimageFile.url!
            let userimageURL = URL(string: userimageUrlString)!
            
            //Use alamofireimage for user profile pic
            userImage.af.setImage(withURL: userimageURL)
        }
        
    }
}
