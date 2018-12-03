//
//  registerViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 10/30/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class registerViewController: UIViewController {

    @IBOutlet weak var toLogInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerTapped(_ sender: Any) {
        
        let user = PFUser()
        
        guard usernameTextField.text != nil, passwordTextField.text != nil,
            emailTextField.text != nil else {
                // Present user with error message
                return
        }


        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        user.signUpInBackground { (success, error) in
            if let error = error as NSError? {
                
                print(error.userInfo)
                let alertController = UIAlertController(title: error.localizedDescription,
                                                        message: nil,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion:  nil)
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        

    }
    @IBAction func toLogInTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "registerToLoginSegue", sender: self)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
