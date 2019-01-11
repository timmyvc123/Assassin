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
//        var gameObject = Game()
        
        if let game = user.object(forKey: "games") as? PFObject {
            game.fetchInBackground(block: result)
//            gameObject.id = game["GameID"] as? String
//            gameObject.name = game["GameName"] as? String
            
            
        }
    }
    
    func createGame(attributes: [String: Any]?, result: @escaping PFBooleanResultBlock) {
        let game = PFObject(className:"Games")
        
        attributes?.forEach({ (attribute) in
            game[attribute.key] = attribute.value
        })
        
        game.saveInBackground(block: result)
        
        var currentGames = PFUser.current()!["GamesArray"] as? [Any]
        if currentGames == nil { currentGames = [] }
        currentGames?.append(game["ObjectId"])
        PFUser.current()!["GamesArray"] = currentGames
        
//        PFUser.current()!["GameArray"] = ["test"]
//
       PFUser.current()?.saveInBackground()
    }
}

struct Game {
    var id: String?
    var name: String?
    var password: String?
    var commisionerID: String?
    var players: [String]?
    
    
}
