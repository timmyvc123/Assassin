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
        user = PFUser.current()
        print("Name: \(String(describing: user.name))")
        print("Username: \(String(describing: user.username))")
        print("Email: \(String(describing: user.email))")
        
        errorLabel.isHidden = true
        if let photo = PFUser.current()?["photo"] as? PFFile {
            photo.getDataInBackground(block: { (data, error) in
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        self.profileImageView.image = image;
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // allows user to only select UIImages as profile picture
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image;
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        
        if let image = profileImageView.image {
            
            if let imageData = UIImagePNGRepresentation(image) {
                
                PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData)
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    if error != nil {
                        var errorMessage = "Update Failed - Try Again"
                        
                        if let newError = error as NSError? {
                            if let detailError = newError.userInfo["error"] as? String {
                                errorMessage = detailError;
                            }
                        }
                        
                        
                    } else {
                        print("Update Successful!")
                    }
                })            }
            
        }
    }
    
}
