//
//  People+Convenience.swift
//  Pair
//
//  Created by Kelsey Sparkman on 4/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import Foundation
import CoreData

extension People {
    convenience init(name: String, moc: NSManagedObjectContext = CoreDataStack.contextMOC) {
        self.init(context: moc)
        self.name = name
    }
}
