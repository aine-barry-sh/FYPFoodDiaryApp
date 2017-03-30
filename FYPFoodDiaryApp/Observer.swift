//
//  Observer.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 30/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import UIKit
import Alamofire

protocol Observing: class {
    func doSomething()
}

protocol Observable {
}

extension Observable {
    private var observers: [Observing] {
        get {
            return [Observing]()
        }
        set {
            //do nothing
        }
    }
    
    mutating func add(observer: Observing) {
        if !observers.contains(where: {$0 === observer}) {
        	observers.append(observer)
        }
    }
    
    mutating func remove(observer: Observing) {
        observers = observers.filter({$0 !== observer})
    }
    
    func notifyAll() {
        for observer in observers {
            observer.doSomething()
        }
    }
}


class InternetObservable : Observable {
    init() {
        if (isInternetAvailable()) {
            notifyAll()
        }
    }
}


class FileChecker : Observable {
    init() {
        if (filesArePresent()) {
            notifyAll()
        }
    }
}

class FileUploader : Observing {
    

    init() {
    
    }
    
    func doSomething() {
    
        if(isInternetAvailable()) {
            attemptUpload()
        }
    }
    
    func attemptUpload() {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: []) as [URL]
            
            // if you want to filter the directory contents you can do like this:
            let jpgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
            for file in jpgFiles {
                
                if (file.lastPathComponent.range(of:"JPEG_iOS") != nil) {
                    sendSinglePicture(imageURL: file)
                    break
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            
        }

        
    
    }
    
    func sendSinglePicture(imageURL : URL) {
        
        let headers: HTTPHeaders = [
            "Content-type" : ConfigRoutes.CONTENT_TYPE_APPLICATION_JSON.rawValue,
            "charset" : "utf-8",
            "authorization": "bearer " + UserDefaults.standard.string(forKey: "access_token")!
        ]
        let imageFiles: Array<[String: String]> = [[
            "Name" : imageURL.lastPathComponent,
            "Base64": self.imageToBase64(imageURL: imageURL)
            ]]
        
        let params: [String: Any] = [
            "MealName" : "Default Name",
            "Images" : imageFiles,
            "FoodItems" : []
            
        ]
        
        
        Alamofire.request(ConfigRoutes.MEALS_SAVE_IMAGE.rawValue, method: .post, parameters: params, encoding: JSONEncoding.default, headers:headers).responseJSON { response in
            switch response.result
            {
            case .success(let data):
                print(data)
            self.deleteFile(imageURL: imageURL)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func imageToBase64(imageURL: URL) -> String {
        
        let imageData : NSData = NSData.init(contentsOf: imageURL)!
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters )
        
        return base64String
        
    }
    
    func deleteFile (imageURL: URL) {
        do {
            let fileManager = FileManager.default
            let path:String = imageURL.path
            if fileManager.fileExists(atPath: path) {
                try fileManager.removeItem(atPath: path)
            } else {
                print("File does not exist")
            }
        } catch {
            print("error with deletion of file")
        }
    }
}
