//
//  Task+Convenience.swift
//  Task
//
//  Created by Bryan Workman on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation

extension Task {
    
    @discardableResult
    convenience init(name: String, notes: String? = nil, due: Date? = nil, isComplete: Bool) {
        self.init(context: CoreDataStack.context)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
    
}
