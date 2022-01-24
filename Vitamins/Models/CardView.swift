//
//  CardView.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/8/22.
//

import SwiftUI

struct CardView: View {
    let med: Medication
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(med.theme.mainColor)
            HStack {
                Text(med.title)
                    .foregroundColor(Color("Text Color"))
                    .font(.title)
                    .bold()
                    
                Spacer()
                //boolean med.vitTaken
                if (med.vitTaken) {
                    HStack {
                        Text("taken")
                            .foregroundColor(Color("Text Color"))
                        Image(systemName: "checkmark.square")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
                else {
                    HStack{
                        Text("Not Taken")
                            .foregroundColor(Color("Text Color"))
                        Image(systemName: "x.square")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
               
            }.padding()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(med: Medication.sampleData[0])
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.dark)
    }
}
