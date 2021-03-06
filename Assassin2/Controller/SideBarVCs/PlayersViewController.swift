//
//  otherUsersViewController.swift
//  Assassin2
//
//  Created by Timmy Van Cauwenberge on 12/3/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import UIKit
import Parse


class PlayersViewController: UITableViewController {

    var players: [Player]! //pointers to object
    var playerList: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for player in players {
            player.fetchInBackground { (player, error) in
                guard let player = player as? Player else { print(error!); return }
                self.playerList.append(player)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: self.playerList.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()
            }
        }

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Setting Number of Rows as \(players.count)")
        return playerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "playerCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell")
        }
        
        if let playerName = playerList[indexPath.row].name {
            cell.playerName.text = playerName

        } else {
            do {
                let name = try playerList[indexPath.row].user.fetch().username
                cell.playerName.text = name
            } catch let error {
                print(error)
            }

        }

        return cell
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


class PlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var playerName: UILabel!
    
}
