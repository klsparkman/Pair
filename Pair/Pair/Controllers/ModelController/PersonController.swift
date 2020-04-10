//
//  PersonController.swift
//  Pair
//
//  Created by Kelsey Sparkman on 4/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import UIKit
import CoreData

class PersonController {
    
    // Mark: - Properties
    static let shared = PersonController()
    
    var people: [People]  = []
//    {
//        let fetchRequest: NSFetchRequest<People> = People.fetchRequest()
//        return (try? CoreDataStack.contextMOC.fetch(fetchRequest)) ?? []
//    }
    //var fetchedRequest: NSAsynchronousFetchRequest <People>
    

    // Mark: - Crud
    func create(name: String) {
        let _ = People(name: name)
        saveToPersistentStore()
    }
    
    func delete(person: People) {
        CoreDataStack.contextMOC.delete(person)
        saveToPersistentStore()
    }
    
    func random() {
        var randomPeople: [People] = []
        for people in people {
            let randomIndex = Int(arc4random_uniform(UInt32(randomPeople.count)))
            randomPeople.insert(people, at: randomIndex)
        }
        people = randomPeople
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.contextMOC.save()
        } catch {
            print("There was an error saving the person! \(#function)\(error.localizedDescription)")
        }
    }
}//End of class
