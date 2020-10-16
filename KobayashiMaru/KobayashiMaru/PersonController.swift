//
//  PersonController.swift
//  KobayashiMaru
//
//  Created by Jordan Bryant on 10/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

class PersonController {
    
    static let shared = PersonController()
    
    var pairsOfPeople: [[Person]] = [[]]
    
    func createNewPerson(name: String) {
        let person = Person(name: name)
        addPerson(person: person)
    }
    
    func addPerson(person: Person) {
        if pairsOfPeople.isEmpty {
            pairsOfPeople.append([person])
            return
        }
        
        var n = 0
        for pair in pairsOfPeople {
            if pair.count != 2 {
                pairsOfPeople[n].append(person)
                return
            }
            n += 1
        }
        
        pairsOfPeople.append([person])
    }
    
    func deletePersonAtIndex(section: Int, row: Int) {
        pairsOfPeople[section].remove(at: row)
        
        if pairsOfPeople[section].count == 1 {
            let oldPartner = pairsOfPeople[section][0]
            pairsOfPeople.remove(at: section)
            addPerson(person: oldPartner)
        }
    }
    
    func shufflePairs() {
        var iterator = pairsOfPeople.joined().shuffled().makeIterator()
        
        pairsOfPeople = pairsOfPeople.map { $0.compactMap { _ in iterator.next() }}
    }

}
