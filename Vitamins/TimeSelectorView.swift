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
    
    
    @State var changeToMin = false
    @State var symbol = "AM"
    @State var angle: Double = 0
    
    @Binding var timePickerViewShown: Bool

    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 18) {
                Spacer()
                HStack(spacing: 0) {
                    
                    Text(data.hourToString() + ":")
                        .font(.largeTitle)
                        .fontWeight(changeToMin ? .light : .bold)
                        .onTapGesture {
                            angle = Double(data.remHour * 30)
                            changeToMin = false
                        }
                    
                    Text(data.minuteToString())
                        .font(.largeTitle)
                        .fontWeight(changeToMin ? .bold : .light)
                        .onTapGesture {
                            angle = Double(data.remMinute * 6)
                            changeToMin = true
                        }
                }
               
                
                VStack(spacing: 8) {
                    Text("AM")
                        .font(.title2)
                        .fontWeight(data.timeDayString() == "AM" ? .bold : .light)
                        .onTapGesture {
                            //symbol = "AM"
                            if (data.remHour >= 12 ) {
                                data.remHour = data.remHour - 12
                            }
                        }
                    
                    Text("PM")
                        .font(.title2)
                        .fontWeight(data.timeDayString() == "PM" ? .bold : .light)
                        .onTapGesture {
                            //symbol = "PM"
                            if (data.remHour < 12 ) {
                                data.remHour = data.remHour + 12
                            }
                        }
                } // End of VStack spacing 8
                .frame(width: 50)
                
            } // end of HStack spacing 15
            .padding()
            .foregroundColor(Color("Text Color"))
            
            
            // Circular Slider...
            TimeSlider(data: $data, angle: $angle, changeToMin: $changeToMin)
            
            Button(action: {
                withAnimation() {
                    
                    timePickerViewShown = false
                    
                }

            }, label: {
                Text("Done")
                    .font(.title2)
                    .fontWeight(.bold)
            })
                .padding(.bottom)
            
            
            
            
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
        TimeSelectorView(data: .constant(Medication.sampleData[0].data), timePickerViewShown: .constant(false))
            .preferredColorScheme(.dark)
    }
}

struct TimeSlider: View {
    
    @Binding var data: Medication.Data
    @Binding var angle: Double
    @Binding var changeToMin: Bool
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                
                // Time Slider...
                let widdth = reader.frame(in: .global).width / 2
                
                // Knob or Circle...
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .offset(x: widdth - 50)
                    .rotationEffect(.init(degrees: angle))
                    .gesture(DragGesture().onChanged(onChanged(value: )).onEnded(onEnd(value: )))
                    .rotationEffect(.init(degrees: -90))
                    
                
                
                
                ForEach(1...12,id: \.self) { index in
                    
                    VStack {
                        Text("\(changeToMin ? index * 5 : index)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Text Color"))
                        // reverting the numbers to be right side up
                            .rotationEffect(.init(degrees: Double(-index) * 30))
                    }
                    .offset(y: -widdth + 50)
                    // rotating Views...
                    // 12*3 = 360 degrees...
                    .rotationEffect(.init(degrees: Double(index) * 30))
                }
                
                // Arrow
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .overlay(
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 2, height: widdth/2)
                        ,alignment: .bottom
                    )
                    .rotationEffect(.init(degrees: angle))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        // Max Height
        .frame(height: 300)
    }
    
    // gesture...
    func onChanged(value: DragGesture.Value) {
        
        //getting angle...
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // circle or knob size is 40
        // so radius = 20
        let radians = atan2(vector.dy - 20, vector.dx - 20)
        
        var angle = radians * 180 / .pi
        
        if angle < 0 {angle = 360 + angle}
        
        self.angle = angle
        
        // disabling for minutes...
        if (!changeToMin) {
            //rounding up the value
            let roundValue = 30 * Int(round(self.angle / 30))
            self.angle = Double(roundValue)
        }
        else {
            // updating minutes
            let progress = angle / 360
            data.remMinute = Int(progress * 60)
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        
        
        
        if (!changeToMin) {
            //updating the hour value...
            data.remHour = Int(angle / 30)
            
            // updating picker to minutes
            withAnimation {
                
                //setting to minutes Value...
                angle = Double(data.remMinute * 6)
                changeToMin = true
            }
        }
        
    }
    
}
