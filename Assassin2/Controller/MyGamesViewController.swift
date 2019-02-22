//
//  menuViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 10/30/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse

class MyGamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private enum MenuState {
        case hidden
        case visible
    }
    
    private var state: MenuState = .hidden

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
    
    
    
    
    

    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) for Menu")
        menuView.isHidden = true
        coverScreenButton.isHidden = true
        menuCurveImageView.image = #imageLiteral(resourceName: "MenuCurve")
        hideMenu()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        

        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        self.tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
    }
    
    func getGames() {
        games = []
        tableView.reloadData()
        if let currentUser = PFUser.current() {
            
            
        let game = Game()
        
        game.name = "gameName.text"
        game.password = "gamePassword.text"
        game.commissioner = PFUser.current()
            print("**************************************")

            print(game.hasStarted)
        game.hasStarted = true
            print(game.hasStarted)
            print("**************************************")

            
//        print("Getting games")
//            currentUser.getGames() { (game) in
//                self.games.append(game)
//                self.tableView.beginUpdates()
//                self.tableView.insertRows(at: [IndexPath(row: self.games.count-1, section: 0)], with: .automatic)
//                self.tableView.endUpdates()
//            }
        }
    }
    
    @objc func handleRefresh() {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        print("Refresh")

        guard let currentUser = PFUser.current() else { return }
        
        currentUser.getGames() { (game) in
            if !self.games.contains(game) {
                self.games.append(game)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: self.games.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
        }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    var games: [Game] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getGames()
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
    
    
    
    // TABLE VIEW
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Setting Number of Rows as \(games.count)")
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "gameCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell")
        }

        guard let players = games[indexPath.row].players else { return cell }

        cell.playerCount.text = String("Players: \(players.count)")
        cell.gameNameLabel.text = games[indexPath.row].name
        return cell
    }
    
    var valueToPass: Game!

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Cell Label
        
        valueToPass = self.games[indexPath.row]
        performSegue(withIdentifier: "ToGameSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToGameSegue") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! GameViewController
            // your new view controller should have property that will store passed value
            viewController.game = valueToPass
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

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var playerCount: UILabel!

    
    
}

