//
//  ContentView.swift
//  Cat or Dog?
//
//  Created by Lukas on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model: AnimalModel
    
    
    var body: some View {
        
        ScrollViewReader { proxy in
            VStack {
                
                GeometryReader { geometry in
                    Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                }
                
                HStack {
                    Text("What is it?")
                        .font(.title)
                        .bold()
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.model.getAnimal()
                        proxy.scrollTo(0,anchor: .top)
                    }, label: {
                        Text("Next")
                            .bold()
                    })
                    .padding(.trailing, 10)
                }
                                
                ScrollView {
                    LazyVStack {
                        ForEach(0..<model.animal.results.count,id:\.self) { index in
                            AnimalRowView(imageLabel: model.animal.results[index].imageLabel, confidence: model.animal.results[index].confidence)
                                .id(index)
                        }
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                    }
                }
                
            }
            .onAppear(perform: model.getAnimal)
            .opacity(model.animal.imageData == nil ? 0 : 1)
            .animation(.easeIn)
        }
    }
}
