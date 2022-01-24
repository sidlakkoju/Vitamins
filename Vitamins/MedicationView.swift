//
//  MedicationView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/30/21.
//

import SwiftUI

struct MedicationView: View {
    
    @Binding var currentMed: Medication
    @Binding var Medications: [Medication]
    @State private var showMedicationsEditView: Bool = false

    var body: some View {
        GeometryReader() { geometry in
            VStack{
                HStack{
                    Button(action: {    // The Edit Button
                        
                        withAnimation(.linear(duration: 1)) {
                            showMedicationsEditView = true
                        }
                        
                    }, label: {
                        Image(systemName: "gear")
                        Text("Edit")
                    })
                    
                    Spacer()
                    
                    Button(action: {    // The Undo Button
                        currentMed.vitTaken = false
                        updateMedications()
                        
                    }, label: {
                        Text("UnTake")
                        Image(systemName: "arrow.uturn.backward.circle")
                        
                    })
                } //End of HStack
                .padding()
                
                
                Text(currentMed.title)
                    .font(.title)
                    .bold()
                    .padding(.top)
                
                
                Spacer()
                    .frame(height: geometry.size.height*0.05)
                
                VStack{
                    Button(action: {    // The VitTaken Button
                                        
                        currentMed.vitTaken = true
                        updateMedications()
                    }, label: {
                        ZStack {
                            Circle()
                            
                                .fill(currentMed.theme.mainColor)
                                .frame(width: 200, height: 200)
                                .shadow(color: currentMed.theme.lightShadow, radius: 10, x: -10, y: -10)
                                .shadow(color: currentMed.theme.darkShadow, radius: 10, x: 10, y: 10)
                             
         
                            if (currentMed.vitTaken) {
                                //https://www.youtube.com/watch?v=095s3BF-yHA -> To add green circular outline animation when vit is taken
                                Text(": )")
                                    .bold()
                                    .font(.largeTitle)
                                    .rotationEffect(Angle(degrees: 90.0))
                            }
                            else {
                                Text(": (")
                                    .bold()
                                    .font(.largeTitle)
                                    .rotationEffect(Angle(degrees: 90.0))
                            }
                        }
                        .foregroundColor(Color("Text Color"))
                    })
                        .padding(.bottom)
                    
                    if (showMedicationsEditView) {
                        
                        
                        DetailEditView(data: currentMed.data, currentMed: $currentMed, Medications: $Medications, showMedicationsEditView: $showMedicationsEditView)
                            .frame(width: geometry.size.width*0.9, height: 300, alignment: .center)
                    }

                } //end of VStack
                Spacer()
            }
            .background(currentMed.theme.mainColor)
        }
    }
    
    
    func updateMedications() {
        var i: Int = 0
        while (i < Medications.count) {
            if (currentMed.id == Medications[i].id) {
                Medications[i] = currentMed
                break
            }
            i = i + 1;
        }
    }
    
    
} //End of MedicationView




struct MedicationView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationView(currentMed: .constant(Medication.sampleData[0]), Medications: .constant(Medication.sampleData) )
            .preferredColorScheme(.dark)
    }
}
