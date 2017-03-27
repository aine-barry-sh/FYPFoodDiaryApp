//
//  LogInRequest.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 18/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import Foundation
import Alamofire


class LogInRequest {


    var successful: Bool?
    var results: JSON?
    
    
    func launch(username: String, password: String) {
        let headers: HTTPHeaders = [
            "Content-type" : "text/html",
            "charset" : "utf-8"
        ]
        
        let parameters: Parameters = [
            "grant_type" : "password",
            "UserName" : username,
            "Password" : password
        ]
        
        Alamofire.request(ConfigRoutes.ACCOUNT_LOGIN.rawValue, method: .post, parameters: parameters, headers:headers).responseJSON { response in
            switch response.result
            {
            case .success(let data):
                self.successful = true
                self.results = JSON(data)
                
            case .failure(let error):
                self.successful = false
                failure(error: error)
            }
        }
    }
    
    
    func response() {
    
        if (successful == true) {
            log_in_success()
        } else {
        }
    }
    
    func log_in_success() {
        
        
        
        if self.results?["error"] == "unsupported_grant_type" {
            //do error things
        } else {
            print(results)
        }
        
        
    }
}
