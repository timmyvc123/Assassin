//
//  Game.swift
//  Assassin2
//
//  Created by Matthew Shober on 1/19/19.
//  Copyright © 2019 Cowabunga Games. All rights reserved.
//

import Foundation
import Parse.PFObject


class Game: PFObject {
    
    //game.name is the same as game["name"]
    
    @NSManaged var name: String?
    @NSManaged var password: String?
    @NSManaged var players: [Player]?
    @NSManaged var commissioner: PFObject?
    @NSManaged var hasStarted: NSNumber? //NSNumber is used to represent a bool

    
    override init() {
        super.init()
        hasStarted = true
    }
    func start() {
        self.hasStarted = true

        guard let players = players?.shuffled() else { return }
        
        for i in 0...players.count {
            if players[i] == players.last {
                players[i].target = players.first
            }
            players[i].target = players[i + 1]
        }
    }
}

extension Game: PFSubclassing {
    static func parseClassName() -> String {
        return "Games"
    }
    
}

