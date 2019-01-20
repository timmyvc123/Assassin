//
//  profileViewController.swift
//  
//
//  Created by Timmy Van Cauwenberge on 12/3/18.
//

import UIKit
import Parse

class profileViewController: UIViewController {

    var user: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = PFUser.current()
        print("Name: \(String(describing: user.name))")
        print("Username: \(String(describing: user.username))")
        print("Email: \(String(describing: user.email))")

        // Do any additional setup after loading the view.
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
