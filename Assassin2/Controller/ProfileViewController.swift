//
//  profileViewController.swift
//  
//
//  Created by Timmy Van Cauwenberge on 12/3/18.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var user: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = PFUser.current()

        errorLabel.isHidden = true
        if let photo = user["photo"] as? PFFile {
            photo.getDataInBackground(block: { (data, error) in
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        print("image loaded")
                        DispatchQueue.main.async {
                            self.profileImageView.image = image;
                        }
                    } else {
                        print(error)
                    }
                }
            })
        }
    }
    
    @IBAction func updateProfileTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = false;

        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // allows user to only select UIImages as profile picture
        print(#function)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                profileImageView.image = image;
                let rootViewController = self.navigationController?.viewControllers.first as! MyGamesViewController
                rootViewController.profileImageView.image = image

        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print(#function)
        profileImageView.image = image
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        print(#function)
        if let image = profileImageView.image {
            
            if let imageData = image.pngData() {
                
                user["photo"] = PFFile(name: "profile.png", data: imageData)
                user.saveInBackground(block: { (success, error) in
                    guard success else {
                        let error = error! as NSError
                        let error_msg = error.userInfo["error"] as! String
                        print(error_msg)
                        return
                    }
                    print("Update Successful!")
                    
                })
            }
        }
    }
    
}
