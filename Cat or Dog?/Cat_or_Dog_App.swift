//
//  Cat_or_Dog_App.swift
//  Cat or Dog?
//
//  Created by Lukas on 10/25/22.
//

import SwiftUI

@main
struct Cat_or_Dog_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: AnimalModel())
        }
    }
}
