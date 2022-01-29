//
//  TimeSelectorView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/29/22.
//

// At 4:31 of the video
// https://www.youtube.com/watch?v=TTewssjh6z8

import SwiftUI

struct TimeSelectorView: View {
    
    /* @State var data: Medication.Data = Medication.Data(title: "", theme: .kindaBlue, vitTaken: false) */
    @Binding var data: Medication.Data
    
    
    var changeToMin = false
    var symbol = "AM"
    
    
    var body: some View {
        VStack {
            HStack(spacing: 18) {
                Spacer()
                Text(data.timeToString())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(spacing: 8) {
                    Text("AM")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("PM")
                        .font(.title2)
                        .fontWeight(.bold)
                } // End of VStack spacing 8
                
            } // end of HStack spacing 15
            .padding()
            .foregroundColor(Color("Text Color"))
            
            
            // Circular Slider...
            GeometryReader { reader in
                ZStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            // Max Height
            .frame(height: 300)
            
            
            
        } // end of VStack
        .frame(width: getWidth() - 120)
        .background(data.theme.accentColor)
        .cornerRadius(10)
    } // end of some View
} // end of View

extension TimeSelectorView {
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}

struct TimeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectorView(data: .constant(Medication.sampleData[0].data))
            .preferredColorScheme(.dark)
    }
}
