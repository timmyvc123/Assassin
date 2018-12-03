//
//  logInViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 10/30/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class logInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var toRegisterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let lastKnownUser = PFUser.current() {
            usernameTextField.text = lastKnownUser.username
        }
    }
    @IBAction func logInTapped(_ sender: Any) {
        
        guard usernameTextField.text != "", passwordTextField.text != "" else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter information for all fields",
                                                    preferredStyle: .alert)
            
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alertController.addAction(retryAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in

            if let error = error as NSError? {

                let alertController = UIAlertController(title: error.localizedDescription,
                                                        message: nil,
                                                        preferredStyle: .alert)
                
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion:  nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    deinit {
        print("\(#function) for log in")
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
