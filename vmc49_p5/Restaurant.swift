//
//  Restaurant.swift
//  vmc49_p5
//
//  Created by Victor Chen on 4/3/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import Foundation

class Restaurant {
    
    var name: String
    var type: String
    var time: String
    var cost: String
    
    init(name: String, type: String, time: String, cost: String) {
        self.name = name
        self.type = type
        self.time = time
        self.cost = cost
    }
}

extension Restaurant: Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type && lhs.time == rhs.time && lhs.cost == rhs.cost
    }
}
