//
//  Tools.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 18/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import UIKit
import SystemConfiguration



var controller: UIViewController?
func create_alert_dialog(title: String, message: String) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
    controller?.present(alertController, animated:true, completion:nil)
    
}


func set_controller(cont: UIViewController) {
    controller = cont
}

public class AlertFun {
    class func ShowAlert(title: String, message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}



func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
}

func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}



func makeImageFileName() -> String {
    let date = NSDate()
    
    let calendar = NSCalendar.current
    let year = String(calendar.component(.year, from:date as Date))
    let month = String(calendar.component(.month, from:date as Date))
    let day = String(calendar.component(.day, from:date as Date))
    let hour = String(calendar.component(.hour, from:date as Date))
    let minute = String(calendar.component(.minute, from:date as Date))
    let second = String(calendar.component(.second, from:date as Date))
    
    let dateString = year + month + day + "_" + hour + minute + second
    
    return "JPEG_iOS_" + dateString + ".jpg"
}

func filesArePresent() -> Bool {
    
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    do {
        // Get the directory contents urls (including subfolders urls)
        let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: []) as [URL]
        
        // if you want to filter the directory contents you can do like this:
        let jpgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
        for file in jpgFiles {
            
            if (file.lastPathComponent.range(of:"JPEG_iOS") != nil) {
                return true
            }
        }
    } catch let error as NSError {
        print(error.localizedDescription)
        return false
    }
    
    return false

}


func dictToJSON(dict:[String: Any]) -> Any {
    let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    let decoded = try! JSONSerialization.jsonObject(with: jsonData, options: [])
    
    return decoded
}

func arrayToJSON(array:[String]) -> Any {
    let jsonData = try! JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
    let decoded = try! JSONSerialization.jsonObject(with: jsonData, options: [])
    return decoded
}

