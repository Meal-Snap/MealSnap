//
//  FeedViewController.swift
//  Meal Snap
//
//  Created by alisha.sunuwar on 4/4/21.
//

import UIKit
import AlamofireImage

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  
    
    //Nancy Ng 
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func onLogOut(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = main.instantiateViewController(identifier: "LoginViewController")
        guard  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate else { return}
        delegate.window?.rootViewController = loginVC
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
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

