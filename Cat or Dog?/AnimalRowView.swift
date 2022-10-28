//
//  AnimalRow.swift
//  Cat or Dog?
//
//  Created by Lukas on 10/28/22.
//

import SwiftUI

struct AnimalRowView: View {
    
    var imageLabel: String
    var confidence: Double
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height:48)
                .cornerRadius(10)
            
            HStack {
                Text(imageLabel)
                Spacer()
                Text(String(format: "%.2f%%", confidence * 100))
            }
        }
        .padding(.horizontal)
        
    }
}
