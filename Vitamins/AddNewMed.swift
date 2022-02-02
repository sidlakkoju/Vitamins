//
//  AddNewMed.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/10/22.
//

import SwiftUI

struct AddNewMed: View {
    

    @Binding var Medications: [Medication]
    @Binding var NewMedicationWindow: Bool
    @Binding var timePickerViewShown: Bool
    
    @Binding var dataStore: Medication.Data

    @Binding var currentMed: Medication


    
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
                                    .shadow(color: dataStore.theme.lightShadow, radius: 10, x: -10, y: -10)
                                    .shadow(color: dataStore.theme.darkShadow, radius: 10, x: 10, y: 10)
                                Text(dataStore.theme.name)
                                    .foregroundColor(Color("Text Color"))
                            }
                        })
                        
                        Button(action: {
                            
                            // Request User Permision to push notifications
                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("Success")
                                }
                                
                                else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }

                            withAnimation() {
                                timePickerViewShown = true
                            }
                            
                        }, label: {
                            HStack {
                                //try to change to large title
                                Image(systemName: "timer")
                                    .font(.title)
                                Text(dataStore.timeToString())
                                    .fontWeight(.bold)
                            }
                        })
                            .padding()
                        
                       
                    }
                    .padding()
                }
            }
            
            Button(action: {
                let localMed = Medication(data: dataStore)
                localMed.scheduleNotification()
                Medications.append(localMed)
                currentMed = localMed
                NewMedicationWindow = false
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
        }
        
    }
}

struct AddNewMed_Previews: PreviewProvider {
    static var previews: some View {
        AddNewMed(Medications: .constant(Medication.sampleData), NewMedicationWindow: .constant(false), timePickerViewShown: .constant(false), dataStore: .constant(Medication.sampleData[0].data), currentMed: .constant(Medication.sampleData[0]))
            .previewLayout(.fixed(width: 400, height: 300))
            .preferredColorScheme(.dark)
    }
}
