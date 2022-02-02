//
//  VitaminsApp.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/30/21.
//

import SwiftUI

@main
struct VitaminsApp: App {
    
//    @State private var listOfMeds: [Medication] = Medication.sampleData
    @State private var currentMed: Medication = Medication.sampleData[0]
    
    @StateObject private var store = MedicationStore()
    
    
    // comment out later
    //@State private var data: Medication.Data = Medication.sampleData[0].data

    var body: some Scene {
        WindowGroup {
            
            CombinedAppView(Medications: $store.Medications, currentMed: $currentMed) {
                
                MedicationStore.save(Medications: store.Medications) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }

            }
                .onAppear {
                    print("Hello")
                    MedicationStore.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(error.localizedDescription)
                        case .success(let meds):
                            store.Medications = meds
                            store.updateMedications()
                        }
                    }
                    
                    
                }
            
            /*
                .onAppear(perform: {
                    print("currentMed Set")
                    currentMed = listOfMeds[0]
                })
             */
            
            /*
            VStack {
                TimeSelectorView(data: $data)
                dataTestFile(data: $data)
            }
             */
        }
    }
}
