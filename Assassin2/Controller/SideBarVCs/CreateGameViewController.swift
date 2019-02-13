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

    
    @IBOutlet weak var rulesTable: UITableView!
    var rules: [String] = []

    @IBOutlet weak var gamePassword: UITextField!
    @IBOutlet weak var gameName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rulesTable.dataSource = self
        rulesTable.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func createGame(_ sender: Any) {
        
        guard gameName.text?.isEmpty == false, gamePassword.text?.isEmpty == false else { return }
        
        let game = Game()
        
        game.name = gameName.text
        game.password = gamePassword.text
        game.commissioner = PFUser.current()
        game.hasStarted = false
        
        PFUser.current()?.createGame(game, result: { (game, error) in
            if error == nil {
                DispatchQueue.main.async { [unowned self] in
                    self.navigationController?.popToRootViewController(animated: false)
                }

//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "CurrentGame") as? MyGamesViewController
//                viewController?.game = game
//                self.navigationController?.pushViewController(viewController!, animated: true)


            } else if error != nil {
                print(error ?? "Error")
            }
        })
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

extension CreateGameViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "rule"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CreateGameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell")
        }
        
        cell.addFieldButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        cell.removeFieldButton.addTarget(self, action: #selector(removeButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        
        cell.ruleNameTextField.addTarget(self, action: #selector(fieldTextEntered(sender:)), for: .editingChanged)
        return cell
    }
    
    @objc func fieldTextEntered(sender: UITextField) {
        if sender.text == "" {
            print("Delete")
            
        }
    }
    
    @objc func removeButtonPressed(sender: UIButton) {
        self.rules.remove(at: 0)
        self.rulesTable.beginUpdates()
        self.rulesTable.insertRows(at: [IndexPath(row: self.rules.count, section: 0)], with: .automatic)
        self.rulesTable.endUpdates()
        
        
    }
    
    @objc func buttonPressed(sender: UIButton) {
        self.rules.append("rule")
        self.rulesTable.beginUpdates()
        self.rulesTable.insertRows(at: [IndexPath(row: self.rules.count, section: 0)], with: .automatic)
        self.rulesTable.endUpdates()
    }
    
}

class CreateGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var removeFieldButton: UIButton!
    @IBOutlet weak var ruleNameTextField: UITextField!
    @IBOutlet weak var addFieldButton: UIButton!
    
    var index: Int?
    
    @IBAction func addFieldButtonPressed(_ sender: Any) {
        print(#function)

        addFieldButton.isHidden = true
        removeFieldButton.isHidden = false
        ruleNameTextField.isHidden = false

    }
}

