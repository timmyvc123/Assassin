//
//  MyGamesViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 11/14/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class GameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private enum MenuState {
        case hidden
        case visible
    }
    
    // All outlets (buttons & labels)
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var coverScreenButton: UIButton!
    @IBOutlet weak var menuCurveImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var rulesLabel: UILabel!
    
    @IBOutlet weak var reportKillButton: UIButton!
    @IBOutlet weak var reportKillLabel: UILabel!
    
    @IBOutlet weak var usersButton: UIButton!
    @IBOutlet weak var usersLabel: UILabel!
    
    @IBOutlet weak var createOrJoinButton: UIButton!
    @IBOutlet weak var createOrJoinLabel: UILabel!
    
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var calendarLabel: UILabel!
    
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var leaderboardLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var signOutLabel: UILabel!
    
    
    private var state: MenuState = .hidden
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) for Menu")
        self.title = game["GameName"] as? String
        menuView.isHidden = true
        coverScreenButton.isHidden = true
        menuCurveImageView.image = #imageLiteral(resourceName: "MenuCurve")
        hideMenu()
        updateMenuImage()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if let currentUser = PFUser.current() {
        //            print("Getting games")
        //            GameManager().getGames(from: currentUser) { (game, error) in
        //                if let error = error {
        //                    print("*** error fetching + \(error) ***")
        //                } else if let game = game {
        //                    print("*** have profile object + id: \(game) ***")
        //                }
        //            }
        //        }
        print("\(#function) for Menu")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function) for Menu")
        
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        PFUser.logOut()
        DispatchQueue.main.async { [unowned self] in
            
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
            self.showIcon(button: self.usersButton, label: self.usersLabel)
            self.showIcon(button: self.createOrJoinButton, label: self.createOrJoinLabel)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.showIcon(button: self.rulesButton, label: self.rulesLabel)
            self.showIcon(button: self.reportKillButton, label: self.reportKillLabel)
            
            self.showIcon(button: self.calendarButton, label: self.calendarLabel)
            self.showIcon(button: self.leaderboardButton, label: self.leaderboardLabel)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImageView.transform = .identity
            self.profileButton.transform = .identity
            self.showIcon(button: self.targetButton, label: self.targetLabel)
            
            self.showIcon(button: self.settingsButton, label: self.settingsLabel)
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
            self.hideIcon(button: self.targetButton, label: self.targetLabel)
            
            self.hideIcon(button: self.settingsButton, label: self.settingsLabel)
            self.hideIcon(button: self.signOutButton, label: self.signOutLabel)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hideIcon(button: self.rulesButton, label: self.rulesLabel)
            self.hideIcon(button: self.reportKillButton, label: self.reportKillLabel)
            
            self.hideIcon(button: self.calendarButton, label: self.calendarLabel)
            self.hideIcon(button: self.leaderboardButton, label: self.leaderboardLabel)
        })
        
        // menuCurveImage goes away (provides bubble animation)
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = CGAffineTransform(translationX: +self.menuCurveImageView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hideIcon(button: self.usersButton, label: self.usersLabel)
            self.hideIcon(button: self.createOrJoinButton, label: self.createOrJoinLabel)
            
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
    
    // TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "messageCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell")
        }
        cell.messageLabel.text = "Message"
        return cell
        
    }
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "ToPlayersSegue") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! PlayersViewController
            // your new view controller should have property that will store passed value
            
            let players = game.players
            
            //            var playerList: [PFObject] = []
            //            for player in players {
            //                player.fetchInBackground { (player, error) in
            //                    guard let player = player else { print(error!); return }
            //                    playerList.append(player)
            //                }
            //            }
            //
            viewController.players = players
        }
    }
    
    func updateMenuImage() {
        if let query = PFUser.query(){
            
            query.findObjectsInBackground { (objects, error) in
                if let users = objects {
                    for object in users {
                        if let user = object as? PFUser {
                            if let imageFile = user["photo"] as? PFFile {
                                imageFile.getDataInBackground(block: { (data, error) in
                                    if let imageData = data {
                                        self.profileImageView.image = UIImage(data: imageData)
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
}

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
}
