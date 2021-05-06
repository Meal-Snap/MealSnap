//
//  FeedViewController.swift
//  Meal Snap
//
//  Created by alisha.sunuwar on 4/4/21.
//

import UIKit
import AlamofireImage
import Parse

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  
    
    //Nancy Ng 
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2) / 3
        layout.itemSize = CGSize(width: width, height: width*1.1)

    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            //here I will make the query
            let query = PFQuery(className: "Recipe")
            query.includeKeys(["author"])
            query.limit = 20 //get the last 20

            query.findObjectsInBackground { (posts, error) in
                if posts != nil { //success
                    self.posts = posts!
                    self.collectionView.reloadData()
                }
                print(posts)
            }
        }
    
    @IBAction func onLogOut(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        delegate.window?.rootViewController = loginVC
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell

        let post = posts[indexPath.item]

        if let user = post["author"] as? PFUser{
            cell.PostUsername.text = user.username
        }
        
        if let imageFile = post["image"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
        
            cell.FoodImageCell.af_setImage(withURL: url)
        }
        return cell
    }
    


    


//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //Task 1 - find selected posts
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        //var post: PFObject!
//
        //Task 2 - Store posts into details controller
        let detailsViewController = segue.destination as! PostDetailsViewController
        detailsViewController.post = post

        //while transitioning, this disables the highlighted feature of each cell that was selected
        collectionView.deselectItem(at: indexPath, animated: true)
    }


}

