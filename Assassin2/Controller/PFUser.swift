//
//  GameManager.swift
//  Assassin2
//
//  Created by Matthew Shober on 11/11/18.
//  Copyright © 2018 Cowabunga Games. All rights reserved.
//

import Foundation
import Parse

extension PFUser {
    
    func getGames(result: @escaping (PFObject) -> ()) {
        
        guard let games = self["games"] as? [PFObject] else { return }
        
        for game in games {
            if !game.isDataAvailable {
                print("Data is not in local storage; fetching from database")
            }
            game.fetchIfNeededInBackground { (game, error) in
                guard let game = game else { print(error!); return }
                
                result(game)
            }

        }
    }
    
    func createGame(attributes: [String: Any]?, result: @escaping (PFObject?, Error?) -> ()) {
        let game = PFObject(className:"Games")
        
        attributes?.forEach({ (attribute) in
            game[attribute.key] = attribute.value
        })
        
        game["PlayerList"] = []
        
        game.saveInBackground { (success, error) in
            if success {
                result(game, nil)
                self.add(game, forKey: "games")
                self.saveInBackground()
            } else {
                result(nil, error)
            }
        }
    }
    
    func joinGame(gameID: String, gamePassword: String, result: @escaping PFBooleanResultBlock) {
        let query = PFQuery(className: "Games")

        query.getObjectInBackground(withId: gameID) { (game, error) in
            guard game?["GamePassword"] as? String == gamePassword else {
                result(false, error)
                return
                
            }
            
            self.add(game!, forKey: "games")
            self.saveInBackground(block: result)
            
            game?.add(self, forKey: "PlayerList")
            game?.saveInBackground()
        }
    }
}

