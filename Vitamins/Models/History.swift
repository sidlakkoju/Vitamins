//
//  History.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/30/21.
//

import Foundation

//should add codeable conformation for saving
struct History: Identifiable, Codable {
    let id: UUID
    let date: Date

    init(id: UUID = UUID(), date: Date = Date()) {
        self.id = id
        self.date = date
    }
}


//lhs and rhs stand for left-hand side and right-hand side respectibly
extension History: Equatable {
    static func == (lhs: History, rhs: History) -> Bool {
        return lhs.id == rhs.id
    }
}

