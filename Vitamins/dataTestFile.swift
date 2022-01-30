//
//  dataTestFile.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 1/30/22.
//

import SwiftUI

struct dataTestFile: View {
    
    @Binding var data: Medication.Data
    
    var body: some View {
        Text(data.timeToString())
        
    }
}

struct dataTestFile_Previews: PreviewProvider {
    static var previews: some View {
        dataTestFile(data: .constant(Medication.sampleData[0].data))
    }
}
