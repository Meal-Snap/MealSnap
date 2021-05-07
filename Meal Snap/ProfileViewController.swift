//
//  ProfileViewController.swift
//  Meal Snap
//
//  Created by Farhene Sultana on 5/6/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var userpic: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var preference: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = user["username"] as? String
        preference.text = user["preference"] as? String
        bio.text = user["bio"] as? String
        
        if let userimageFile = user["userpic"] as? PFFileObject{
            let userimageUrlString = userimageFile.url!
            let userimageURL = URL(string: userimageUrlString)!
            
            //Use alamofireimage for user profile pic
            userpic.af.setImage(withURL: userimageURL)
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
