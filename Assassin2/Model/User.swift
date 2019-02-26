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
    @NSManaged var name: String?
    @NSManaged var games: [Game]
    
    func getGames(result: @escaping (Game) -> ()) {
        
        print(String(describing: self) + ": " + #function)
        for game in games {
            print(game)
            if !game.isDataAvailable {
                print("Data is not in local storage; fetching from database")
            }
            game.fetchInBackground { (game, error) in
                guard let game = game as? Game else { print(error!); return }
                
                result(game)
            }
        }
    }
    
    func createGame(_ game: Game, result: @escaping (Game?, Error?) -> ()) {

        game.commissioner = Commissioner(from: self)

        game.saveInBackground { (success, error) in
            if success {
                result(game, nil)
                self.games.append(game)
                self.saveInBackground()
            } else {
                print("Error")
                result(nil, error)
            }
        }
    }
    
    func joinGame(gameID: String, gamePassword: String, result: @escaping PFBooleanResultBlock) {
        let query = Game.query()!
        
        query.getObjectInBackground(withId: gameID) { (game, error) in
            guard let game = game as? Game else { result(false, error); return }
            guard game.password == gamePassword else { result(false, error); return }
            
            self.games.append(game)
            self.saveInBackground()
            
            game.players.append(Player(from: self))
            game.saveInBackground()

            result(true, nil)
        }
    }
}


