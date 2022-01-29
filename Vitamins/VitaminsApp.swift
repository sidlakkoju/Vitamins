//
//  VitaminsApp.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/30/21.
//

import SwiftUI

@main
struct VitaminsApp: App {
    @State private var listOfMeds: [Medication] = Medication.sampleData
    @State private var currentMed: Medication = Medication.sampleData[0]
    

    var body: some Scene {
        WindowGroup {
            CombinedAppView(Medications: $listOfMeds, currentMed: $currentMed)
                .onAppear(perform: {
                    print("currentMed Set")
                    currentMed = listOfMeds[0]
                })
        }
    }
    
}
