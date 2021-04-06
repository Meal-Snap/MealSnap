//
//  LoginViewController.swift
//  Meal Snap
//
//  Created by alisha.sunuwar on 4/4/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        print("username :", username,"password :", password)
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
                self.showErrorDialog(error: (String(describing: error!.localizedDescription)))
            }
        }
        
    }
    
   
    
     @IBAction func onSignUp(_ sender: Any) {
            let user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            user.signUpInBackground{(success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
                self.showErrorDialog(error: (String(describing: error!.localizedDescription)))
            }
         }
     }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
    }
    
        
}

extension LoginViewController{
    func showErrorDialog(error : String){
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { action in
            
        }))
        
        self.present(alert, animated: true)
    }
}
