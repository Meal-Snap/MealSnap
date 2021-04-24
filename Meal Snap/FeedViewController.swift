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
    var userName = [String]!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    

    
    @IBAction func onLogOut(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = main.instantiateViewController(identifier: "LoginViewController")
        guard  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate else { return}
        delegate.window?.rootViewController = loginVC
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell

            let post = posts[indexPath.item]
        
            let user = posts["author"] as! PFUser
            cell.PostUsername.text = user.username
        
            let image = posts["image"] as! PFFileObject
            let urlString = image.url!
            let url = URL(string: urlString)!

                //remember the ?? are about optionals!
            cell.posterView.af_setImage(withURL: url)


            return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            //here I will make the query
            let query = PFQuery(className: "Posts")
            query.includeKeys(["author"])
            query.limit = 20 //get the last 20

            query.findObjectsInBackground { (posts, error) in
                if posts != nil { //success
                    self.posts = posts!
                    self.collectionView.reloadData()
                }
            }
        }

    


//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //Task 1 - find selected posts
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let post = posts[indexPath.row]

        //Task 2 - Store movie into details controller
        let detailsViewController = segue.destination as! PostDetailsViewController
        detailsViewController.post = post

        //while transitioning, this disables the highlighted feature of each cell that was selected
        collectionView.deselectItem(at: indexPath, animated: true)
    }


}

