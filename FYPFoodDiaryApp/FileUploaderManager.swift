//
//  FileUploaderManager.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 20/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import Foundation
import UIKit
import Alamofire



class FileUploaderManager {
    
    var jpgFiles: [URL]
    
    var token: String

    init(setToken: String) {
        
    
        jpgFiles = []
        self.token = setToken
    
    }
    
    
    func getFilesInDirectory() {
        
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: []) as [URL]
            
            // if you want to filter the directory contents you can do like this:
            self.jpgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    func attemptSending() {
        
    }
    
    func sendSinglePicture(imageURL: URL) {
        
//        let headers: HTTPHeaders = [
//            "Content-type" : ConfigRoutes.CONTENT_TYPE_APPLICATION_JSON.rawValue,
//            "charset" : "utf-8",
//            "authorization": "bearer " + self.token
//        ]
//        
//      
//        let imageFile = EncodedImageFile (
//            Name: imageURL.lastPathComponent,
//            Base64: imageToBase64(imageURL: imageURL)
//        )
//        let param = MealsSaveImagesDto(
//            MealName: "Default Name",
//            FoodItems:[],
//            Images: [imageFile]
//        )
//        
//        let parameters: Parameters = [
//            "Name" : "Default Name",
//            "Images" : [
//                "Name" : imageURL.lastPathComponent,
//                "Base64": self.imageToBase64(imageURL: imageURL)
//            ]
//        ]
//        
//        Alamofire.request(ConfigRoutes.MEALS_SAVE_IMAGE.rawValue, method: .post, parameters: param, encoding: .JSON, headers:headers).responseJSON { response in
//            switch response.result
//            {
//            case .success(let data):
//                self.deleteFile(imageURL: imageURL)
//            case .failure(let error):
//                self.errorAlert(message: error.localizedDescription)
//                
//            }
//        }
        
        
    }
    
    func imageToBase64(imageURL: URL) -> String {
    
        let imageData : NSData = NSData.init(contentsOf: imageURL)!
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters )
        
        return base64String
        
    }
    
    func checkResult(results: JSON) {
        
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
    
    func errorAlert(message: String) {
        
        print(message)
    }

    
}
