//
//  DetailEditView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/10/22.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var currentMed: Medication
    @Binding var Medications: [Medication]
    @Binding var showMedicationsEditView: Bool
    
    
    
    @Binding var timePickerViewShown: Bool
    
    @Binding var dataStore: Medication.Data


    @State private var currentDate = Date()

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(dataStore.theme.mainColor)
                VStack {
                    TextField("Medication Name", text: $dataStore.title)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.system(size: 25, weight: .heavy, design: .default))
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(dataStore.theme.mainColor)
                                    .shadow(color: dataStore.theme.lightShadow, radius: 5, x: -5, y: -5)
                                    .shadow(color: dataStore.theme.darkShadow, radius: 5, x: 5, y: 5)
                                Text(dataStore.theme.name)
                                    .foregroundColor(Color("Text Color"))
                            }
                        })
                        
                        Button(action: {
                            withAnimation() {
                                timePickerViewShown = true
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "timer")
                                Text(dataStore.timeToString())
                                    .fontWeight(.bold)
                            }
                        })
                        .padding()
                    }
                    .padding()
                }
            }
            
            HStack {
                Button(action: {
                    withAnimation {
                        currentMed.update(from: dataStore)
                        
                        currentMed.cancelNotification() // Cancel all the repeating Notification scheduled for the old time.
                        currentMed.scheduleNotification() // Once again schedule the Notifications for the new time.
                        
                        updateMedications()
                        showMedicationsEditView = false
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 50, alignment: .center)
                        Text("Done")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color("Text Color"))
                            
                    }
                    
                })
                    .padding()
                
                Button(action: {
                    withAnimation {
                        showMedicationsEditView = false
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 50, alignment: .center)
                        Text("Cancel")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color("Text Color"))
                            
                    }
                    
                })
                    .padding()
            }
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
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(currentMed: .constant(Medication.sampleData[0]), Medications: .constant(Medication.sampleData), showMedicationsEditView: .constant(false), timePickerViewShown: .constant(false), dataStore: .constant(Medication.sampleData[0].data))
            .previewLayout(.fixed(width: 400, height: 300))
            .preferredColorScheme(.dark)
    }
}
