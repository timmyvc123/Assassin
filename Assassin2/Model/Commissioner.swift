//
//  Commissioner.swift
//  Assassin2
//
//  Created by Matthew Shober on 2/22/19.
//  Copyright © 2019 Cowabunga Games. All rights reserved.
//

import Foundation
import Parse

class Commissioner: PFObject {
    
    @NSManaged var user: PFUser

    convenience init(from user: PFUser) {
        self.init()
        self.user = user
    }
}

extension Commissioner: PFSubclassing {
    static func parseClassName() -> String {
        return "Commissioner"
    }
}

