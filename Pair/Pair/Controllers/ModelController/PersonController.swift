//
//  PersonController.swift
//  Pair
//
//  Created by Kelsey Sparkman on 4/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import UIKit
typealias People = String

class PersonController {
    
    // Mark: - Properties
    static let shared = PersonController()
    
    var people: [People]  = []
    
    init() {
        loadPerson()
    }

    // Mark: - Crud
    func create(newPerson: People) {
        people.append(newPerson)
        save()
    }
    
    func delete(person: People) {
        guard let index = people.firstIndex(of: person) else {return}
        people.remove(at: index )
        save()
    }
    
    func random() {
        var randomPeople: [People] = []
        for people in people {
            let randomIndex = Int(arc4random_uniform(UInt32(randomPeople.count)))
            randomPeople.insert(people, at: randomIndex)
        }
        people = randomPeople
    }
    
    func save() {
        UserDefaults.standard.set(people, forKey: PersonController.personKey)
    }
    
    static let personKey = "PersonKey"
    func loadPerson() {
        guard let savedPerson = UserDefaults.standard.array(forKey: PersonController.personKey) as? [People] else {return}
        people = savedPerson
    }
}//End of class
