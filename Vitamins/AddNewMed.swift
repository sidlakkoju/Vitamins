//
//  AddNewMed.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/10/22.
//

import SwiftUI

struct AddNewMed: View {
    @State var data: Medication.Data = Medication.Data(title: "", theme: .kindaBlue, vitTaken: false)
    
    @Binding var Medications: [Medication]
    @Binding var NewMedicationWindow: Bool
    
    
    @State private var currentDate = Date()


    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(data.theme.mainColor)
                VStack {
                    TextField("Medication Name", text: $data.title)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(.system(size: 25, weight: .heavy, design: .default))
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(data.theme.mainColor)
                                    .shadow(color: data.theme.lightShadow, radius: 10, x: -10, y: -10)
                                    .shadow(color: data.theme.darkShadow, radius: 10, x: 10, y: 10)
                                Text(data.theme.name)
                                    .foregroundColor(Color("Text Color"))
                            }
                        })

                        HStack {
                            Image(systemName: "timer")
                            DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                        }
                        .padding(.trailing)
                        .padding(.leading)
                    }
                    .padding()
                }
            }
            
            Button(action: {
                Medications.append(Medication(data: data))
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
        AddNewMed(data: Medication.sampleData[0].data, Medications: .constant(Medication.sampleData), NewMedicationWindow: .constant(false))
            .previewLayout(.fixed(width: 400, height: 300))
            .preferredColorScheme(.dark)
    }
}
