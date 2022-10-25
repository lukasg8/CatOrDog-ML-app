//
//  Animal.swift
//  Cat or Dog?
//
//  Created by Lukas on 10/25/22.
//

import Foundation

class Animal {
    
    // url for image
    var imageUrl: String
    
    // image data
    var imageData: Data?
    
    init() {
        
        self.imageUrl = ""
        self.imageData = nil
        
    }
    
    // json will be a dictionary of Strings (keys) and Any (values)
    init?(json: [String: Any]) {
        
        // check that JSON has url
        guard let imageUrl = json["url"] as? String else {
            return nil
        }
        
        // set animal properties
        self.imageUrl = imageUrl
        self.imageData = nil
        
        // download the image data
        getImage()
        
    }
    
    func getImage() {
        
    }
    
}
