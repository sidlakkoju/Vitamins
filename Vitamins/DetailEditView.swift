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
    @State private var themeCounter: Int = 1;
    @State private var showingAlert = false
    
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
                            themeCounter+=1
                            if (themeCounter > 3) {
                                themeCounter = 1
                            }
                            
                            if (themeCounter == 1) {
                                dataStore.theme = .kindaBlue
                            }
                            else if (themeCounter == 2) {
                                dataStore.theme = .veryPurple
                            }
                            else if (themeCounter == 3) {
                                dataStore.theme = .whatsGreen
                            }
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
                
                Button(action: {
                    
                    
                    showingAlert = true
                    
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.red)
                            .frame(width: 100, height: 50, alignment: .center)
                            
                        Text("Delete")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Color("Text Color"))
                            
                    }
                })
                    .alert("Are you sure you want to Delete this Medication?", isPresented: $showingAlert) {
                                Button("Delete") {
                                    var i: Int = 0
                                    while (i < Medications.count) {
                                        if (currentMed.id == Medications[i].id) {
                                            Medications.remove(at: i)
                                            break
                                        }
                                        i = i + 1;
                                    }
                                    withAnimation {
                                        showMedicationsEditView = false
                                        if (Medications.count > 0) {
                                            currentMed = Medications[0]
                                            dataStore = currentMed.data
                                        }
                                        else {
                                            currentMed = Medication.sampleData[0]
                                        }
                                    }
                                    
                                }
                                Button("Cancel") { showingAlert = false}
                            }
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
