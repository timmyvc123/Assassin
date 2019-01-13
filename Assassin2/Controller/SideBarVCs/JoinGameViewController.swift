//
//  JoinGameViewController.swift
//  Assassin2
//
//  Created by Matthew Shober on 1/11/19.
//  Copyright © 2019 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class JoinGameViewController: UIViewController {
    
    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var gamePassword: UITextField!
    
    @IBAction func joinGame(_ sender: Any) {
        
        guard let id = gameName.text, let password = gamePassword.text else { return }
        PFUser.current()?.joinGame(gameID: id, gamePassword: password, result: { (success, error) in
            if success {
                print("Success")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                if let error = error as NSError? {
                    print(error.userInfo["code"]!) }
                }
        })
      
    }
 
    
}
