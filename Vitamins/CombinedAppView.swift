//
//  CombinedAppView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/30/21.
//

// https://blog.techchee.com/how-to-create-a-pop-up-view-with-swiftui/ -> If you want to incorporate a pop-up view

import SwiftUI

struct CombinedAppView: View {
    
    @Binding var Medications: [Medication]
    @Binding var currentMed: Medication
    
    @State private var bottomSheetShown = false//Makes the Slide view thingy work
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                MedicationView(currentMed: $currentMed, Medications: $Medications) //curent med is updating but it isnt updating the med in the Medications array
                
                
                BottomSheetView (
                    isOpen: self.$bottomSheetShown,
                    maxHeight: geometry.size.height * 0.7
                ) {
                    AllMedsView(Medications: $Medications, currentMed: $currentMed, bottomSheetShown: $bottomSheetShown)
                }
                .shadow(color: currentMed.theme.lightShadow, radius: 10, x: -10, y: -10)
                .shadow(color: currentMed.theme.darkShadow, radius: 10, x: 10, y: 10)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
        
}
    

struct CombinedAppView_Previews: PreviewProvider {
    static var previews: some View {
        CombinedAppView(Medications: .constant(Medication.sampleData),
                        currentMed: .constant(Medication.sampleData[0]))
            .preferredColorScheme(.dark)
    }

}
