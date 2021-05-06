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
            
            //Use alamofireimage
            imagePost.af.setImage(withURL: imageURL)
        }
        
        
        
//        let urlString = userImage.image!
//        let url = URL(string: urlString)!
        
//        let purlString = imagePost.image!
//        let post_url = URL(string: purlString)!
//
//        //imagePost.af_setImage(withURL: url)
//        userImage.af_setImage(withURL: post_url)
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
