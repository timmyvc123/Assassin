//
//  joinCreateViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 12/3/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class CreateGameViewController: UIViewController {

    
    
    
    @IBOutlet weak var gamePassword: UITextField!
    @IBOutlet weak var gameName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func createGame(_ sender: Any) {
        
        guard gameName.text?.isEmpty == false, gamePassword.text?.isEmpty == false else { return }
        
        
        let game = Game()
        
        game.name = gameName.text!
        game.password = gamePassword.text!
//        game.commissioner = PFUser.current()!
        
        if let currentUser = PFUser.current() {
            currentUser.createGame(game) { (game, error) in
                if error == nil {
                    DispatchQueue.main.async { [unowned self] in
                        self.navigationController?.popToRootViewController(animated: false)
                    }
                } else {
                    print(error ?? "Error")
                }
            }
        }
    }
    
    

}
