//
//  GameManager.swift
//  Assassin2
//
//  Created by Matthew Shober on 11/11/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import Foundation
import Parse

class GameManager {
    
    func getGame(from user: PFUser, result: @escaping PFObjectResultBlock) {
        if let game = user.object(forKey: "games") as? PFObject {
            game.fetchInBackground(block: result)
        }
    }
    
    func createGame(attributes: [String: Any]?, result: @escaping PFBooleanResultBlock) {
        let game = PFObject(className:"Game")
        
        attributes?.forEach({ (attribute) in
            game[attribute.key] = attribute.value
        })
        
        game.saveInBackground(block: result)
    }
}
