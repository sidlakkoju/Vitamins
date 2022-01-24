//
//  MedicationStore.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/31/21.
//

import Foundation


class MedicationStore {
    var Medications: [Medication]
    
    init () {
        self.Medications = []
    }
    
    func addMedication(theme: Theme, title: String) {
        self.Medications.append(Medication(title: title, theme: theme))
    }
    
    func removeMedication(med: Medication) {
       
        
    }
}
