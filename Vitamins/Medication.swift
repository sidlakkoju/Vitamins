//
//  Medications.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/26/21.
//

import Foundation
import CoreImage
import SwiftUI

//should add codeable conformation to save
struct Medication: Identifiable {
    var title: String
    var theme: Theme
    
    var vitTaken: Bool
    let id: UUID
    
    var history: [History] = []
    

    
    
//  When a new medication is made initialize ->
//      Constant Parameters ->
//          - vitTaken = false
//          - id = UUID()
//      User Defined Parameters
//          - theme: Theme
//          - title: String
    init(id: UUID = UUID(), vitTaken: Bool = false, title: String, theme: Theme ) {
        self.title = title
        self.theme = theme
        self.vitTaken = vitTaken
        self.id = id
    }
}

extension Medication {
    struct Data {
        var title: String = ""
        var theme: Theme = .kindaBlue
        var vitTaken: Bool = false
    }
    
    var data: Data {
        Data(title: title, theme: theme, vitTaken: vitTaken)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        theme = data.theme
        vitTaken = data.vitTaken
    }
    
    init(data: Data) {
        id = UUID()
        
        title = data.title
        theme = data.theme
        vitTaken = data.vitTaken
    }
}

extension Medication {
    static var sampleData: [Medication] =
    [
        Medication(title: "Vitamin C", theme: .kindaBlue),
        Medication(title: "Vitamin D", theme: .kindaBlue),
        Medication(title: "Drug D", theme: .kindaBlue),
    ]
    
}
