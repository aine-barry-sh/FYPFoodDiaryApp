//
//  Requests.swift
//  FoodNutritionApp
//
//  Created by Aine Barry on 06/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import UIKit
import Alamofire


protocol Request {
}

protocol GetReqest: Request {
}

protocol PostRequest: Request {
}

func test_data_request() {
    let url = URL(string: ConfigRoutes.ACCOUNT_LOGIN.rawValue)
    
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        guard error == nil else {
            print(error!)
            return
        }
        guard let data = data else {
            print("Data is empty")
            return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        print(json)
        
    }
    
    
    
    task.resume()
    
    
    
    
    
}

func post_request(route: String, parameters: Parameters, headers: HTTPHeaders){
    
//    
//    Alamofire.request(route, method: .post, parameters: parameters, headers: headers).responseJSON{
//        response in
//        
//        if let value = response.result.value as? [String: Any] {
//           
//        }
//    }
    
}


func attempt_log_in(username: String, password: String) -> String{
    
    let headers: HTTPHeaders = [
        "Content-type" : "text/html",
        "charset" : "utf-8"
    ]
    
    let parameters: Parameters = [
        "grant_type" : "password",
        "UserName" : username,
        "Password" : password
    ]
    var toReturn : String = "failure"
    
    Alamofire.request(ConfigRoutes.ACCOUNT_LOGIN.rawValue, method: .post, parameters: parameters, headers:headers).responseJSON { response in
        
        switch response.result {
            case .success(let data):
                let json = JSON(data)
                let name = json["error"].stringValue
                print(name)
            
                if ((name ?? "").isEmpty) {
                        print("emptyString")
                }
            
            
            case .failure(let error):
                print("Request failed with error: \(error)")
            
        }
        
       
   
    }

     return toReturn
    
    
}

func log_in() 
{
    
    let headers: HTTPHeaders = [
        "Content-type" : "text/html",
        "charset" : "utf-8"
    ]
    
    let parameters: Parameters = [
        "grant_type" : "password",
        "UserName" : "aine.barry@hotmail.com",
        "Password" : "Goldie-94"
    ]
    Alamofire.request(ConfigRoutes.ACCOUNT_LOGIN.rawValue, method: .post, parameters: parameters, headers:headers).responseJSON { response in
        switch response.result
        {
            case .success(let data):
                log_in_success(result: JSON(data))
            case .failure(let error):
                failure(error: error)
        }
    }
}


func log_in_success(result: JSON) {

}

func failure(error: Error) {

}




//func test_two_post() {
//    let urlToRequest = "http://193.1.97.61:8080/token"
//    
//    let encodingString = "grant_type=password&username=aine.barry@hotmail.com&password=Goldie-94"
////    let encodedString = encodingString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//    
//    
//    
//    let url4 = URL(String: "http://193.1.97.61:8080/token".strin)
//    let session4 = URLSession.shared
//    
//    let request = NSMutableURLRequest(url:url4!)
//    request.httpMethod = "POST"
//    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//    request.httpBody = encodingString.data(using: String.Encoding.utf8)
//    
//    let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
//        guard error == nil else {
//            print(error!)
//            return
//        }
//        guard let data = data else {
//            print("Data is empty")
//            return
//        }
//        
//        let json = try! JSONSerialization.jsonObject(with: data, options: [])
//        print(json)
//    
//    }
//    task.resume()
//}
//
//
//func test_post_request() {
//    
//    let url = URL(string: ConfigRoutes.ACCOUNT_LOGIN.rawValue)!
//    
//    let dto = LogInDto(UserName:"aine.barry@hotmail.com", Password:"Goldie-94")
//    let jsonData = dto.toJSON()
//    let encodedString = jsonData?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//    
//    let session = URLSession.shared
//    let request = NSMutableURLRequest(url: url)
//    request.httpMethod = "POST"
//    request.httpBody = encodedString?.data(using: String.Encoding.utf8)
//    request.addValue(ConfigRoutes.CONTENT_TYPE_TEXT_HTML.rawValue, forHTTPHeaderField:"Content-Type")
//    
//    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//        guard error == nil else {
//            print(error!)
//            return
//        }
//        guard let data = data else {
//            print("Data is empty")
//            return
//        }
//        
//        let json = try! JSONSerialization.jsonObject(with: data, options: [])
//        print(json)
//        
//    }
//    task.resume()
//}


