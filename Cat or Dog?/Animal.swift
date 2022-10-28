//
//  Animal.swift
//  Cat or Dog?
//
//  Created by Lukas on 10/25/22.
//

import Foundation
import CoreML
import Vision

struct Result: Identifiable {
    
    var id = UUID()
    var imageLabel:String
    var confidence:Double
}

class Animal {
    
    // url for image
    var imageUrl: String
    
    // image data
    var imageData: Data?
    
    // classified results
    var results: [Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    
    init() {
        
        self.imageUrl = ""
        self.imageData = nil
        self.results = []
        
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
        self.results = []
        
        // download the image data
        getImage()
        
    }
    
    func getImage() {
        
        // create url object
        let url = URL(string: imageUrl)
        
        
        // check url is not nil
        guard url != nil else {
            print("Couldn't get URL Object")
            return
        }
        
        // get url session
        let session = URLSession.shared
        
        
        // create data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            // check there are no errors and that there was data
            if error == nil && data != nil {
                self.imageData = data
                
                // after getting image, classify image
                self.classifyAnimal()
            }
        }
        
        dataTask.resume()
        
    }
    
    func classifyAnimal() {
        
        // get reference to the model
        let model = try! VNCoreMLModel(for: modelFile.model)
        
        // create an image handler
        let handler = VNImageRequestHandler(data: imageData!)
        
        // create a request to the model
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Couldn't classify animal")
                return
            }
            
            // update results
            for classification in results {
                
                var identifier = classification.identifier
                
                // make first letter capitalized for presentation
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                self.results.append(Result(imageLabel: identifier, confidence: Double(classification.confidence)))
                
            }
                    
        }
        
        // execute the request
        do {
            try handler.perform([request])
        }
        catch {
            print("Invalid image")
        }
        
        
    }
    
}
