//
//  ViewController.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 13/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var rememberMeSlider: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.password.delegate = self;
        self.username.delegate = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        set_controller(cont: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
      
        
        let usernameString:String = username.text!
        let passwordString:String = password.text!
        
        let headers: HTTPHeaders = [
            "Content-type" : "text/html",
            "charset" : "utf-8"
        ]
        
        let parameters: Parameters = [
            "grant_type" : "password",
            "UserName" : usernameString,
            "Password" : passwordString
        ]
        
        Alamofire.request(ConfigRoutes.ACCOUNT_LOGIN.rawValue, method: .post, parameters: parameters, headers:headers).responseJSON { response in
            switch response.result
            {
            case .success(let data):
                self.processLogIn(results: JSON(data))
            case .failure(let error):
                self.errorAlert(message: error.localizedDescription)
                
            }
        }
    }
    
    func processLogIn(results: JSON) {
        
        if (results["error_description"].exists()) {
            errorAlert(message: results["error_description"].string!)
        } else {
            UserDefaults.standard.set(results["access_token"].string, forKey:"access_token")
            UserDefaults.standard.set(results["expires_in"].string, forKey:"expires_in")
            UserDefaults.standard.set(rememberMeSlider.isOn, forKey:"remember_me")
            goToMainView()
            
        }
        
        

    }
    
    func goToMainView() {
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView") as! MainViewController
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    
    func testMethod() {
        create_alert_dialog(title: "test", message: "test")
    }
    
    
    func errorAlert(message:String) {
    
        
        let alert = UIAlertController(title: "Error message", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


