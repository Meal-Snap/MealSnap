//
//  SettingsViewController.swift
//  Meal Snap
//
//  Created by Farhene Sultana on 5/6/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var preferencesChange: UITextField!
    @IBOutlet weak var bioChange: UITextView!
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func onProfilePic(_ sender: Any) {
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
        let scaledImage = image.af.imageScaled(to: size)
        
        profilePic.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        //user["username"] = usernameChange.text!
        user["preference"] = preferencesChange.text!
        user["bio"] = bioChange.text!
        
        let imageData = profilePic.image!.pngData()
        let file = PFFileObject(data: imageData!)
        user["userpic"] = file
        
        user.saveInBackground { (success, err) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Updated Profile!")
            }
            else{
                print("Error updating profile!")
            }
        }
    }
    
}
