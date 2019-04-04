//
//  Filter.swift
//  vmc49_p5
//
//  Created by Victor Chen on 3/31/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import Foundation

class Filter{
    
    var name: String
    var isSelected: Bool
    
    init(name: String) {
        self.name = name
        self.isSelected = false
    }
}

extension Filter: Equatable {
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
}
