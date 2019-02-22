//
//  Player.swift
//  Assassin2
//
//  Created by Matthew Shober on 2/12/19.
//  Copyright © 2019 Cowabunga Games. All rights reserved.
//

import Foundation
import Parse

class Player: PFObject {
    
    @NSManaged var user: PFUser?
    @NSManaged var game: Game?
    
    @NSManaged var name: String?
    @NSManaged var target: Player?
    @NSManaged var status: String?

    
    
    func getGame(result: @escaping (Game) -> ()) {
        
        guard let game = self.game else { return }
        
        if !game.isDataAvailable {
            print("Data is not in local storage; fetching from database")
        }
        game.fetchInBackground { (game, error) in
            guard let game = game as? Game else { print(error!); return }
            
            result(game)
        }
    }
    
    func createGame(_ game: Game, result: @escaping (Game?, Error?) -> ()) {
        

        game.players = []
        
        game.saveInBackground { (success, error) in
            if success {
                result(game, nil)
                self.game = game
                self.saveInBackground()
            } else {
                result(nil, error)
            }
        }
    }
    
    convenience init(from user: PFUser) {
        self.init()
        self.user = user

    }
    
    func joinGame(gameID: String, gamePassword: String, result: @escaping PFBooleanResultBlock) {
        let query = Game.query()!
        
        query.getObjectInBackground(withId: gameID) { (game, error) in
            
            guard let game = game as? Game else { result(false, error); return }
            guard game.password == gamePassword else { result(false, error); return }
            
            self.add(game, forKey: "games")
            //            self.games?.append(game)
            
            
            self.saveInBackground()
            game.add(self, forKey: "players")
            //            game.players?.append(self)
            
            game.saveInBackground()
            
            result(true, nil)
        }
    }
}

extension Player: PFSubclassing {
    static func parseClassName() -> String {
        return "Player"
    }
}
