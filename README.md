# MealSnap

## Team Members:
- Farhene Sultana
- Nancy Jennifer Ng
- Sam Gustafsson
- Alisha Sunuwar

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description

Our social media app is aimed for foodies or food lovers (same idea 😆)!
We aim to create a platform where foodies can post their recipes and also a caption along with an image of their foods. 
Users will be able to search via the search field to find foods to try out or check out as well as like the posts and hopefully comment.
Users will also be prompted upon account creation to select their food preferences (as we plan to) to then have their feed show other users’s foods that align to their taste.
We wanted to separate the food out of all social media and have it in one social platform so that it’s easier to find posts on just food! :3

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Media
- **Mobile:** This app would be primarily developed for mobile. Functionality would be limited to mobile devices.
- **Story:** Shows food posts to other users. Users can post their food pics as well as recipes and a description about their food post. Users can also like other posts as well as hopefully comment and grow their food choices outside of what they know.
- **Market:** Any individual could choose to use this app, and to keep it a safe environment, people would be required to add allergy warnings.
- **Habit:** This app could be used as often or unoften as the user wanted depending on what they want to cook, whether it be Japanese or Mediterranean, Vegan, or perhaps dietary preferences...etc.
- **Scope:** First users should mark their dietary preferences. Then we could try to show them results of other posts that match their dietary preferences. They can eventually search other food types in the search bar.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

*[x] User can login
* [x]User can register
* [x] User can create posts
    *[] Each post must have allergy warnings
* [x]User can view the feed

**Optional Nice-to-have Stories**

* []User can view their profile
* []User can edit their profile
* [x]User can view specific posts
* []User can like posts
* []User can comment on posts
* []User can search for food filters


### 2. Screen Archetypes

* Login Screen
   * User can login
* Register Screen
    * User can register
* Creation Screen
    * User can create posts
* Stream
   * User can view the feed
   * User can search for food filters

**Extra Optional Screen Archetypes**
* Profile
    * User can view their profile
    * User can edit their profile
* Detail
    * User can view specific posts
* Settings
    * Users can maybe view dark mode

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stream Tab
    * Users can view feed
* Creation Tab
    * Users can create post
* Profile (Optional - Extra)
    * Users can view/edit their profile

**Flow Navigation** (Screen to Screen)

* Login/Sign Up
   * Stream Screen
       * Users can view gallery
* Stream
   * Creation Screen
       * Users can create posts
    * Login Screen
        * If Users logged out
   * Recipe View Screen
        * User can view recipe in a separate page

    * Profile Screen [Optional]
* Creation
    * Stream Screen

* Profile [Optional]
    * Stream Screen

## Wireframes
<img src="https://cdn.discordapp.com/attachments/815981484744900630/832627908522278963/image0.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | caption       | String   | image caption by author |
   | likesCount    | Number   | number of likes for the post |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | recipe        | Pointer to Post | recipe that user added in their post |

#### Users
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | emailVerified | Boolean  | email verifier (default field) |
   | username      | String   | unique name of User |
   | password      | String   | unique password of User |
   | email         | String   | unique email of User |
   | author        | Pointer to User| image of author |
   | image         | File     | profile image of user |
   | bio           | String   | profile bio by author |
   | createdAt     | DateTime | date when user account is created (default field) |
   | updatedAt     | DateTime | date when user updates their image or bio (default field) |

#### Likes 
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | createdAt     | DateTime | date when user account is created (default field) |
   | updatedAt     | DateTime | date when user updates their image or bio (default field) |
   
#### Recipe 
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | createdAt     | DateTime | date when recipe is created (default field) |
   | title         | String   | title of the recipe of the Post |
   | ingredients   | String   | ingredients of the recipe of the Post |
   | directions    | String   | instructions on how to make the food from recipe of the Post | 
   | author        | Pointer to Post | 



### Networking
- [Basic snippets for each Parse network request]
   - Login/Sign Up Screen 
      - (Create/POST) Create a new user object
      - (Read/GET) Query logged in user object to log in 
        ```swift
        let username = usernameField.text!
        let password = passwordField.text!
        print("username :", username,"password :", password)
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: (String(describing: error?.localizedDescription))")
                self.showErrorDialog(error: (String(describing: error!.localizedDescription)))
            }
        }
        ```
   - Home Feed Screen
      - (Read/GET) Query all posts where user is author {Note: we kept the sample code here because we feel we could borrow from it}
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
      - [OPTIONAL] (Read/GET) Query all posts which user seeks for [whether it is #glutenfree... etc]
      - (Create/POST) Create a new like on a post
      - (Delete) Delete existing like
   - Create Post Screen
      - (Create/POST) Create a new post object
         ```swift
         let post = PFObject(className: "Posts")

        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!

        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)

        post["image"] = file

        post.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("Error!")
            }
        }
         ```
   - Create Recipe Screen
      - (Create/POST) Create a recipe under the post object
         ```swift
        let recipe = PFObject(className: "Recipe")

        recipe["title"] = titleField.text!
        recipe["ingredients"] = itemField.text!
        recipe["directions"] = directionsField.text!
        recipe["author"] = PFUser.current()!

        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)

        recipe["image"] = file

        recipe.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("Error!")
            }
        }
         ```
   - Profile Screen
      - (Read/GET) Query logged in user object
         ```swift
         let query = PFQuery(className:"User")
         query.whereKey("author", equalTo: currentUser)
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
           // TODO: Do something with Profile...
            }
         }
         ```
      - (Update/PUT) Update user profile image
      - (Update/PUT) Update user bio
      - [OPTIONAL] (Read/GET) Query all posts which the user had posted
   - PostDetail Screen
      - (Read/GET) Query all details connected to one post including Recipe, image, caption, likesCount...etc
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
           // TODO: Do something with Posts to access the details of the Post...
            }
         }
         ```
   - RecipeDetail Screen
      - (Read/GET) Query all details connected to the recipe object under that post
         ```swift
         let query = PFQuery(className:"Recipe")
         query.whereKey("author", equalTo: currentUser)
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
           // TODO: Do something with Profile...
            }
         }
         ```
