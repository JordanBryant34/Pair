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
    
    //MARK: - CRUD
    func createNewPerson(name: String) {
        let person = Person(name: name)
        addPerson(person: person)
        saveToPersistentStore()
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
        
        saveToPersistentStore()
    }
    
    func deletePersonAtIndex(section: Int, row: Int) {
        pairsOfPeople[section].remove(at: row)
        
        if pairsOfPeople[section].count == 1 {
            let oldPartner = pairsOfPeople[section][0]
            pairsOfPeople.remove(at: section)
            addPerson(person: oldPartner)
        }
        
        saveToPersistentStore()
    }
    
    func shufflePairs() {
        var iterator = pairsOfPeople.joined().shuffled().makeIterator()
        
        pairsOfPeople = pairsOfPeople.map { $0.compactMap { _ in iterator.next() }}
        
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "pairs.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)

        return fullURL
    }

    func saveToPersistentStore() {
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(pairsOfPeople)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving pairs: \(error.localizedDescription)")
        }
    }

    func loadFromPersistentStore() {
        let decoder = JSONDecoder()

        do {
            let data = try Data(contentsOf: fileURL())
            let pairsOfPeople = try decoder.decode([[Person]].self, from: data)
            self.pairsOfPeople = pairsOfPeople
        } catch let error {
            print("Error loading from storage: \(error.localizedDescription)")
        }
    }
    
}
