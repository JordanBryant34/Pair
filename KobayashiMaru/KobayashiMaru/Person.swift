//
//  Person.swift
//  KobayashiMaru
//
//  Created by Jordan Bryant on 10/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

class Person: Codable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Person: Equatable {}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
}
