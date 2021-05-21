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
    @IBOutlet weak var likeButton: UIButton!
    var post: PFObject!
    
    var user = PFUser()
    
    //Two lines below are for Liked Feature
    var ifLiked: Bool = false //Nancy Ng Like Button Implementation
    
    var likedArray:[PFUser]!
    
        
 
  
    
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
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        likedArray = post["Liked"] as? [PFUser]
        likedBefore()

        print("is it liked before: " , likedBefore())
    }
    
    @IBAction func likeButton(_ sender: Any) {
        likedBefore()
        
        if !(likedBefore()){
            userLiked()
        }
        else if (likedBefore()){
            UnlikedPost()
        }
    }
    
    //checking if the user has liked the post before
    func likedBefore()->Bool{
       
        //it's always going to be an array so use !
        let liked_before = likedArray.contains(PFUser.current()!)
        
        if (liked_before){
            likeButton.setImage(UIImage(named:"heart_filled"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named:"heart_empty"), for: UIControl.State.normal)
            
        }
        return liked_before
        
    }
    
    //another method, add tap gesture recognizer, so that if it is unfilled, then fill it, and doing so would solidate the whole thing into one function
    // -> if user UNLIKES -> if likedArray contains the user, remove them and then unfill array
    // -> if user LIKES -> append to likedArray, and then fill heart.
    // if user is IN the array, then they are unliking it, and if they
    // are NOT in the array then you should add them.
    
    //calls setLiked button to set the image below
 
    func userLiked() {
        print("liking now")
        likedArray.append(PFUser.current()!)
        likedBefore()
        updateParse()
    }
    
    //for user unliked- save for unit 12
    func UnlikedPost()  {
        print("unliking now")
        let query = PFQuery(className:"Recipe")
        
        //find user
        let targetToUnlike = PFUser.current()!
       
        //iterate through array and to remove at specific index
        var num = 0
        for i in likedArray {
            if(i == targetToUnlike){
                likedArray.remove(at: num)
                likedBefore()
                print("successfully removed")
            }
            num = 1 + num
        }
        
        
        //save in background
        query.getObjectInBackground(withId: post.objectId!) { (post: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let post = post {
                post["Liked"]  = self.likedArray
                post.saveInBackground()
            }
        }
        updateParse()

    }
    
    func updateParse(){
    //this function is called when it is liked, 
        let query = PFQuery(className:"Recipe")
        query.getObjectInBackground(withId: post.objectId!) { (post: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let post = post {
                post["Liked"]  = self.likedArray
                post.saveInBackground()
            }
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
        next?.recipe = post
    }
}
