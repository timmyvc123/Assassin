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

    
    @IBOutlet weak var rulesHeader: RulesView!
    var rules: [String] = []
    
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var ruleTextField: UITextField!
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {

        guard rulesHeader.rules > 1 else { return }
        if sender.direction == .left {
            if rulesHeader.rules > rulesHeader.ruleOffset {
                rulesHeader.ruleOffset += 1
                rulesHeader.setNeedsDisplay()
            }
        }
        if sender.direction == .right {
            if rulesHeader.ruleOffset > 0 {
                rulesHeader.ruleOffset -= 1
                rulesHeader.setNeedsDisplay()
            }
        }
    }
    
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addRule(_ sender: Any) {
//        rulesHeader.addRule()
        if rulesHeader.rules == 0 {
            ruleTextField.isHidden = false
            ruleLabel.isHidden = true
        }
        rulesHeader.rules += 1
        rulesHeader.setNeedsDisplay()
        
    }

}




class RulesView: UIView {

    lazy var centerY = self.bounds.maxY / 2
    let width = CGFloat(5)

    var rules = 0
    var ruleOffset = 0
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        var rightSpacing = CGFloat(5)
        var leftSpacing = CGFloat(5)


        aPath.move(to: CGPoint(x: 0, y: centerY))
        aPath.addLine(to: CGPoint(x: 0 + centerY, y: 0))
        aPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY, y: 0))
        aPath.addLine(to: CGPoint(x: self.bounds.maxX, y: centerY))
        aPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY, y: self.bounds.maxY))
        aPath.addLine(to: CGPoint(x: 0 + centerY, y: self.bounds.maxY))
        aPath.addLine(to: CGPoint(x: 0, y: centerY))
        UIColor.lightGray.set()
        aPath.fill()
        
        guard rules > 1 else { return }

        if rules - ruleOffset >= 2 {
            for i in 2...rules - ruleOffset {
                let bPath = UIBezierPath()
                bPath.move(to: CGPoint(x: self.bounds.maxX - centerY - rightSpacing, y: 0))
                bPath.addLine(to: CGPoint(x: self.bounds.maxX - rightSpacing, y: centerY))
                bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - rightSpacing, y: self.bounds.maxY))
                
                bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - rightSpacing, y: self.bounds.maxY))
                bPath.addLine(to: CGPoint(x: self.bounds.maxX - width - rightSpacing, y: centerY))
                bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - rightSpacing, y: 0))
                bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - rightSpacing, y: 0))
                
                UIColor.gray.set()
                bPath.fill()
                rightSpacing += 7
                
            }
        }
        
        
        guard ruleOffset > 0 else { return }
        for i in 1...ruleOffset {
            let bPath = UIBezierPath()
            bPath.move(to: CGPoint(x: 0 + centerY + leftSpacing, y: 0))
            bPath.addLine(to: CGPoint(x: 0 + leftSpacing, y: centerY))
            bPath.addLine(to: CGPoint(x: 0 + centerY + leftSpacing, y: self.bounds.maxY))
            
            bPath.addLine(to: CGPoint(x: 0 + centerY + width + leftSpacing, y: self.bounds.maxY))
            bPath.addLine(to: CGPoint(x: 0 + width + leftSpacing, y: centerY))
            bPath.addLine(to: CGPoint(x: 0 + centerY + width + leftSpacing, y: 0))
            bPath.addLine(to: CGPoint(x: 0 + centerY + leftSpacing, y: 0))
            
            UIColor.gray.set()
            bPath.fill()
            leftSpacing += 7
            
        }
        
//
//
//
//        let bPath = UIBezierPath()
//        bPath.move(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - spacing, y: centerY))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: self.bounds.maxY))
//
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: self.bounds.maxY))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - width - spacing, y: centerY))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: 0))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//
//        UIColor.gray.set()
//        bPath.fill()
//
//        spacing += 10
//        do {
//            let bPath = UIBezierPath()
//
//
//            bPath.move(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - spacing, y: centerY))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: self.bounds.maxY))
//
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: self.bounds.maxY))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - width - spacing, y: centerY))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: 0))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//
//            UIColor.gray.set()
//            bPath.fill()
//        }
//
//        spacing += 10
//
//        do {
//            let bPath = UIBezierPath()
//
//
//            bPath.move(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - spacing, y: centerY))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: self.bounds.maxY))
//
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: self.bounds.maxY))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - width - spacing, y: centerY))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: 0))
//            bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//
//            UIColor.gray.set()
//            bPath.fill()
//        }
    }
//    
//    func addRule() {
//        print("addRule")
//        spacing += 10
//
//        let bPath = UIBezierPath()
//
//
//        bPath.move(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - spacing, y: centerY))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: self.bounds.maxY))
//
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: self.bounds.maxY))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - width - spacing, y: centerY))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - width - spacing, y: 0))
//        bPath.addLine(to: CGPoint(x: self.bounds.maxX - centerY - spacing, y: 0))
//
//        UIColor.gray.set()
//        bPath.fill()
//    
//    }
    
}

//class CreateGameViewController: UIViewController {
//
//
//    @IBOutlet weak var rulesHeader: UIView!
//    @IBOutlet weak var rulesTable: UITableView!
//    var rules: [String] = []
//
//    @IBOutlet weak var gamePassword: UITextField!
//    @IBOutlet weak var gameName: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        rulesTable.dataSource = self
//        rulesTable.delegate = self
//        rulesHeader.backgroundColor = UIColor.black
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//
//    @IBAction func createGame(_ sender: Any) {
//
//        guard gameName.text?.isEmpty == false, gamePassword.text?.isEmpty == false else { return }
//
//
//        let game = Game()
//
//        game.name = gameName.text!
//        game.password = gamePassword.text!
//        //        game.commissioner = PFUser.current()!
//
//        if let currentUser = PFUser.current() {
//            currentUser.createGame(game) { (game, error) in
//                if error == nil {
//                    DispatchQueue.main.async { [unowned self] in
//                        self.navigationController?.popToRootViewController(animated: false)
//                    }
//                } else {
//                    print(error ?? "Error")
//                }
//            }
//        }
//    }
//
//
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}
//
//extension CreateGameViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rules.count + 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier = "rule"
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CreateGameTableViewCell  else {
//            fatalError("The dequeued cell is not an instance of TableViewCell")
//        }
//
//        cell.addFieldButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
//
//        cell.removeFieldButton.addTarget(self, action: #selector(removeButtonPressed(sender:)), for: UIControl.Event.touchUpInside)
//
//
//        cell.ruleNameTextField.addTarget(self, action: #selector(fieldTextEntered(sender:)), for: .editingChanged)
//        return cell
//    }
//
//    @objc func fieldTextEntered(sender: UITextField) {
//        if sender.text == "" {
//            print("Delete")
//
//        }
//    }
//
//    @objc func removeButtonPressed(sender: UIButton) {
//        self.rules.remove(at: 0)
//        self.rulesTable.beginUpdates()
//        self.rulesTable.insertRows(at: [IndexPath(row: self.rules.count, section: 0)], with: .automatic)
//        self.rulesTable.endUpdates()
//
//
//    }
//
//    @objc func buttonPressed(sender: UIButton) {
//        self.rules.append("rule")
//        self.rulesTable.beginUpdates()
//        self.rulesTable.insertRows(at: [IndexPath(row: self.rules.count, section: 0)], with: .automatic)
//        self.rulesTable.endUpdates()
//    }
//
//}
//
//extension CreateGameViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return rules.count + 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier = "rule"
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CreateGameTableViewCell  else {
//            fatalError("The dequeued cell is not an instance of TableViewCell")
//        }
//
//        cell.addFieldButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControl.Event.touchUpInside)
//
//        cell.removeFieldButton.addTarget(self, action: #selector(removeButtonPressed(sender:)), for: UIControl.Event.touchUpInside)
//
//
//        cell.ruleNameTextField.addTarget(self, action: #selector(fieldTextEntered(sender:)), for: .editingChanged)
//        return cell
//    }
//
//    @objc func fieldTextEntered(sender: UITextField) {
//        if sender.text == "" {
//            print("Delete")
//
//        }
//    }
//
//    @objc func removeButtonPressed(sender: UIButton) {
//        self.rules.remove(at: 0)
//        self.rulesTable.beginUpdates()
//        self.rulesTable.insertRows(at: [IndexPath(row: self.rules.count, section: 0)], with: .automatic)
//        self.rulesTable.endUpdates()
//
//
//    }
//
//    @objc func buttonPressed(sender: UIButton) {
//        self.rules.append("rule")
//        self.rulesTable.beginUpdates()
//        self.rulesTable.insertRows(at: [IndexPath(row: self.rules.count, section: 0)], with: .automatic)
//        self.rulesTable.endUpdates()
//    }
//
//}
//
//
//
//class CreateGameTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var removeFieldButton: UIButton!
//    @IBOutlet weak var ruleNameTextField: UITextField!
//    @IBOutlet weak var addFieldButton: UIButton!
//
//    var index: Int?
//
//    @IBAction func addFieldButtonPressed(_ sender: Any) {
//        print(#function)
//
//        addFieldButton.isHidden = true
//        removeFieldButton.isHidden = false
//        ruleNameTextField.isHidden = false
//
//    }
//}

