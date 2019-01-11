//
//  joinCreateViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 12/3/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class joinCreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var gamePassword: UITextField!
    @IBOutlet weak var gameName: UITextField!
    @IBAction func createGame(_ sender: Any) {
        let gameManager = GameManager()
        var gameAttributes: [String: Any] = [:]
        gameAttributes["GameName"] = gameName.text
        gameAttributes["GamePassword"] = gamePassword.text
        gameAttributes["CommissionerID"] = PFUser.current()
        gameManager.createGame(attributes: gameAttributes) { (success, error) in
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                let viewController = storyboard.instantiateViewController(withIdentifier: "CurrentGame") as? MyGamesViewController
                
                self.navigationController?.pushViewController(viewController!, animated: true)
            } else if error != nil {
                print(error)
            }
        }
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
