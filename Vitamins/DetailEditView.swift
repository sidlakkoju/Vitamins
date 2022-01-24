//
//  DetailEditView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/10/22.
//

import SwiftUI

struct DetailEditView: View {
    @State var data: Medication.Data
    @Binding var currentMed: Medication
    @Binding var Medications: [Medication]
    @Binding var showMedicationsEditView: Bool
    
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
                                    .shadow(color: data.theme.lightShadow, radius: 5, x: -5, y: -5)
                                    .shadow(color: data.theme.darkShadow, radius: 5, x: 5, y: 5)
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
            
            HStack {
                Button(action: {
                    withAnimation {
                        currentMed.update(from: data)
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
        DetailEditView(data: Medication.sampleData[0].data, currentMed: .constant(Medication.sampleData[0]), Medications: .constant(Medication.sampleData), showMedicationsEditView: .constant(false))
            .previewLayout(.fixed(width: 400, height: 300))
            .preferredColorScheme(.dark)
    }
}