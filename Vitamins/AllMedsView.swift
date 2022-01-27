//
//  AllMedsView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/8/22.
//

import SwiftUI

struct AllMedsView: View {
    
    
    @Binding var Medications: [Medication]
    @Binding var currentMed: Medication
    
    @Binding var bottomSheetShown: Bool
    @State private var NewMedicationWindow: Bool = false
    
    var body: some View {
        GeometryReader() { geometry in
            ScrollView {
                VStack {
                    Text("Other Medications")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    ForEach($Medications, id:\.id) { $med in
                        
                        Button(action: {
                            currentMed = med
                            bottomSheetShown = false
                        }, label: {
                            CardView(med: med)
                                .frame(width: geometry.size.width*0.9, height: 100, alignment: .center)
                                .padding(.bottom)
                                .padding(.leading)
                                .padding(.trailing)
                        })
                    }
                    if (!NewMedicationWindow) {
                        Button(action: {
                            withAnimation(.linear(duration: 1)) {
                                NewMedicationWindow = true
                            }
                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .frame(width: geometry.size.width*0.9, height: 100, alignment: .center)
                                HStack {
                                    Image(systemName: "plus.square")
                                        .foregroundColor(Color("Text Color"))
                                    Text("Add New Medication")
                                        .font(.callout)
                                        .bold()
                                        .foregroundColor(Color("Text Color"))
                                }
                                
                            }
                        })
                    } // end of Add New Medication if statement
                    
                    if (NewMedicationWindow) {
                        AddNewMed(Medications: $Medications, NewMedicationWindow: $NewMedicationWindow)
                            .frame(width: geometry.size.width*0.9, height: 300, alignment: .center)
                            .padding(.trailing)
                            .padding(.leading)
                            .padding(.bottom)
                    }
                    
                } //End of VStack
            } //End of scrollView
        } // End of Geometry Reader
        
    }
        
}

struct AllMedsView_Previews: PreviewProvider {
    static var previews: some View {
        AllMedsView(Medications: .constant(Medication.sampleData),
                    currentMed: .constant(Medication.sampleData[0]),
                    bottomSheetShown: .constant(true))
            .preferredColorScheme(.dark)
    }
}
