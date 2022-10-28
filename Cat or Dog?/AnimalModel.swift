//
//  AnimalModel.swift
//  Cat or Dog?
//
//  Created by Lukas on 10/25/22.
//

import Foundation

class AnimalModel: ObservableObject {
    
    @Published var animal = Animal()
    
    func getAnimal() {
        
        let stringUrl = Bool.random() ? catUrl : dogUrl
        
        // create url object
        let url = URL(string: stringUrl)
        
        // check that url isn't nil
        guard url != nil else {
            print("Could not create URL object")
            return
        }
        
        // get url session
        let session = URLSession.shared
        
        // create data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                // attempt to parse json
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                        
                        // if json is empty, return empty dictionary
                        let item = json.isEmpty ? [:] : json[0]
                        
                        if let animal = Animal(json: item) {
                            
                            DispatchQueue.main.async {
                                while animal.results.isEmpty {}
                                self.animal = animal
                            }
                            
                        }
                    }
                 }
                catch {
                    print("Could not parse JSON")
                }
            }
            
        }
        
        // start the data task
        dataTask.resume()
        
    }
    
}
