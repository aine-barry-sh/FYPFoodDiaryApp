//
//  MainViewController.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 19/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import UIKit
import SystemConfiguration
import MapKit
import CoreLocation
import Alamofire

class MainViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    //var locationManager = CLLocationManager()
    var imagePath : URL!
    var imageData : Data!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Will not work on emulator because no camera. 
    //Should trigger the error alert
    @IBAction func launchCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            errorAlert(message: "Was unable to access camera")
        }
    }
    
    @IBAction func launchGalleryButton(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else  {
            errorAlert(message: "Was unable to access gallery")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(makeImageFileName())
            self.imagePath = URL(fileURLWithPath: paths)
            self.imageData = UIImageJPEGRepresentation(image, 0.5)
        } else {
            errorAlert(message: "was unable to load selected image")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmPhotoButton(_ sender: Any) {
        
        saveImageDocumentDirectory()

        messageAlert(message: "Your will be uploaded at the best possible time!")
        
    }
    
    
    
    //inspired by http://stackoverflow.com/questions/40300703/swift-3-0-getting-url-of-uiimage-selected-from-uiimagepickercontroller
    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        fileManager.createFile(atPath: self.imagePath.path, contents: self.imageData, attributes: nil)
        imageView.image = nil
    }
    
    func messageAlert(message:String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func errorAlert(message:String) {
        
        
        let alert = UIAlertController(title: "Error message", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   
   
}
