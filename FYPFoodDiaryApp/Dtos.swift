//
//  Dtos.swift
//  FoodNutritionApp
//
//  Created by Aine Barry on 06/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import Foundation


struct LogInDto: JSONSerializable{
    var UserName: String
    var Password: String
}

struct AccountRegisterDto: JSONSerializable {
    var Email: String
    var Password: String
    var ConfirmPassword: String
}

struct AccountChangePasswordDto: JSONSerializable {
    var OldPassword: String
    var NewPassword: String
    var ConfirmPassword: String
}

struct FoodItemDto: JSONSerializable {
    var TransferString: String
}

struct MealsSaveImagesDto: JSONSerializable {
    var MealName: String
    var FoodItems = [FoodItemDto]()
    var Images = [EncodedImageFile]()
}
struct EncodedImageFile {
    var Name: String
    var Base64: String
}
