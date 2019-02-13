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
    @NSManaged var players: [PFUser]?
    @NSManaged var commissioner: PFObject?
    @NSManaged var hasStarted: NSNumber? //NSNumber is used to represent a bool

    func start() {
        self.hasStarted = true
        // code to assign targets
        self.players?.randomElement()

    }
}

extension Game: PFSubclassing {
    static func parseClassName() -> String {
        return "Games"
    }
    
}

