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
    @Binding var showMedicationsEditView: Bool
    @Binding var timePickerViewShown: Bool
    @Binding var dataStore: Medication.Data
    
    var body: some View {
        GeometryReader() { geometry in
            VStack{
                HStack{
                    Button(action: {    // The Edit Button
                        dataStore = currentMed.data
                        withAnimation(.linear(duration: 1)) {
                            showMedicationsEditView = true
                        }
                        
                    }, label: {
                        Image(systemName: "gear")
                        Text("Edit")
                    })
                    
                    Spacer()
                    
                    Button(action: {    // The Undo Button
                        
                        // Remove from record the meidcation was taken
                        if (currentMed.vitTaken) {
                            currentMed.history.remove(at: currentMed.history.count - 1)
                        }
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
                        
                        // Check to see if more than a weeks worth of data is not being stored.
                        if (currentMed.history.count == 7) {
                            currentMed.history.remove(at: 0)
                        }
                        
                        // Add a new History element
                        currentMed.history.append(History())
                        
                        // Update the medication
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
                        DetailEditView(currentMed: $currentMed, Medications: $Medications, showMedicationsEditView: $showMedicationsEditView, timePickerViewShown: $timePickerViewShown, dataStore: $dataStore)
                            .frame(width: geometry.size.width*0.9, height: 300, alignment: .center)
                    }
                    else {
                        if (currentMed.history.count > 0) {
                            Text("Last Taken: " + currentMed.history[currentMed.history.count - 1].printDate())
                                .foregroundColor(Color("Text Color"))
                        }
                        else {
                            Text("Medication Not Taken Yet")
                                .foregroundColor(Color("Text Color"))
                        }
                        
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
        MedicationView(currentMed: .constant(Medication.sampleData[0]), Medications: .constant(Medication.sampleData), showMedicationsEditView: .constant(false), timePickerViewShown: .constant(false), dataStore: .constant(Medication.sampleData[0].data))
            .preferredColorScheme(.dark)
    }
}
