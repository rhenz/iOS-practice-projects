//
//  StructExample.swift
//  Structs-vs-Classes
//
//  Created by JLCS on 5/26/21.
//

import Foundation

struct StructHero {
    var name: String
    var universe: String
    
    mutating func reverseName() {
        self.name = String(self.name.reversed())
    }
}


