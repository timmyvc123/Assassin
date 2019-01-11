//
//  menuViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 10/30/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class menuViewController: UIViewController {

    
    private enum MenuState {
        case hidden
        case visible
    }
    
    // side menu outlets
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var coverScreenButton: UIButton!
    @IBOutlet weak var menuCurveImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var createOrJoinButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    
 
    
    // side menu label outlets
    @IBOutlet weak var createOrJoinLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var signOutLabel: UILabel!

    
    // misc
    @IBOutlet weak var tempButton: UIButton!
    
    @IBOutlet weak var profileButton: UIButton!
    
    
    
    
    
    private var state: MenuState = .hidden

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) for Menu")
        menuView.isHidden = true
        coverScreenButton.isHidden = true
        menuCurveImageView.image = #imageLiteral(resourceName: "MenuCurve")
        hideMenu()
        
        
        let gm = GameManager()
        gm.getGame(from: PFUser.current()!) { (game, error) in
            print("Game:")
            print(game)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentUser = PFUser.current() {
            print("Getting games")
            GameManager().getGame(from: currentUser) { (game, error) in
                if let error = error {
                    print("*** error fetching + \(error) ***")
                } else if let game = game {
                    print("*** have profile object + id: \(game) ***")
                }
            }
        }
        print("\(#function) for Menu")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) for Menu")

    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        PFUser.logOut()
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let navigationController = storyboard.instantiateViewController(withIdentifier: "NavController") as? UINavigationController
            
            self.present(navigationController!,
                         animated: true,
                         completion: nil)
            
        }
    }
    
    
    @IBAction func menuTapped(_ sender: Any) {
        if state == .hidden {
            showMenu()
            state = .visible
        } else {
            hideMenu()
            state = .hidden
            
        }
    }
    
    @IBAction func screenCoverTapped(_ sender: Any) {
        hideMenu()
        state = .hidden

    }
    
    func showMenu() {
        
        menuView.isHidden = false
        coverScreenButton.isHidden = false
        
        // side menu comes out
        UIView.animate(withDuration: 0.7) {
            
            self.coverScreenButton.alpha = 1
        }
        
        // menuCurveImage comes out (provides bubble animation)
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = .identity
        })
    
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.showIcon(button: self.createOrJoinButton, label: self.createOrJoinLabel)
            
            self.showIcon(button: self.settingsButton, label: self.settingsLabel)

        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImageView.transform = .identity
            self.profileButton.transform = .identity
            self.showIcon(button: self.signOutButton, label: self.signOutLabel)
        })

    }
    
    func hideMenu() {
        // side menu goes away
        UIView.animate(withDuration: 0.7) {
            self.coverScreenButton.alpha = 0
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImageView.transform = CGAffineTransform(translationX: +self.menuView.frame.width, y: 0)
            self.profileButton.transform = CGAffineTransform(translationX: +self.menuView.frame.width, y: 0)
            
            self.hideIcon(button: self.signOutButton, label: self.signOutLabel)
            
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hideIcon(button: self.settingsButton, label: self.settingsLabel)
            
            self.hideIcon(button: self.createOrJoinButton, label: self.createOrJoinLabel)
        })
        
        // menuCurveImage goes away (provides bubble animation)
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = CGAffineTransform(translationX: +self.menuCurveImageView.frame.width, y: 0)
            
        }) { success in
            self.menuView.isHidden = true
        }
    }
    
    
    func hideIcon(button : UIButton, label : UILabel) {
        button.transform = CGAffineTransform(translationX: +self.menuView.frame.width, y: 0)
        label.transform = CGAffineTransform(translationX: +self.menuView.frame.width, y: 0)
        
    }
    
    func showIcon(button : UIButton, label : UILabel) {
        button.transform = .identity
        label.transform = .identity
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: + Navigation

    // In a storyboard+based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

