//
//  Config.swift
//  FoodNutritionApp
//
//  Created by Aine Barry on 06/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import Foundation


enum ConfigRoutes: String {

    case ACCOUNT_LOGIN = "http://193.1.97.61:8080/token"
    
    case ACCOUNT_REGISTER = "http://193.1.97.61:8080/api/Account/Register"
    case ACCOUNT_LOGOUT = "http://193.1.97.61:8080/api/Account/Logout"
    case ACCOUNT_CHANGE_PASSWORD = "http://193.1.97.61:8080/api/Account/ChangePassword"
    case ACCOUNT_VALIDATE_SESSION = "http://193.1.97.61:8080/api/Account/ValidateSession"
    case MEALS_SAVE_IMAGE = "http://193.1.97.61:8080/api/Meals/UploadImageMeal"
    case CONTENT_TYPE_TEXT_HTML = "text/html"
    case CONTENT_TYPE_APPLICATION_JSON = "application/json"
    case CONTENT_TYPE_MULTIPART_FORMDATA = "multipart/form-data; boundary="
    case CHARSET_UTF8 = "utf-8"
}

enum ConfigTimeOuts: Int {
    case ACCOUNT_LOGIN_TIMEOUT, ACCOUNT_LOGOUT_TIMEOUT, ACCOUNT_VALIDATE_SESSION_TIMEOUT = 10000
    case ACCOUNT_REGISTER_TIMEOUT, ACCOUNT_CHANGE_PASSWORD_TIMEOUT = 20000
    case MEALS_SAVE_IMAGE_TIMEOUT = 240000
    
}
