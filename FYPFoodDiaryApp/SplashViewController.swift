//
//  SplashViewController.swift
//  FYPFoodDiaryApp
//
//  Created by Aine Barry on 19/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //it kept trying to change view before the current view had been loaded so was not
        //in the hierarchy
        //performing with a slight delay fixes issue and does not cause notable delay
        
        
        
        
        //for the sake of testing , always sending to main activity 
        
        perform(#selector(redirectToMain), with: nil, afterDelay: 0)
        
//        
//        if (UserDefaults.standard.object(forKey: "access_token") != nil) {
//            tokenIsPresent()
//        } else {
//            perform(#selector(redirectToLogin), with: nil, afterDelay: 0)
//        }
//        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func tokenIsPresent() {
        if (Date().millisecondsSince1970 < UserDefaults.standard.integer(forKey:"expires_in") && UserDefaults.standard.bool(forKey:"remember_me")) {
            perform(#selector(redirectToMain), with: nil, afterDelay: 0)
            
        } else {
            perform(#selector(redirectToLogin), with: nil, afterDelay: 0)
            
        }
    
    }
    
    func redirectToLogin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "loginView") as! ViewController
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    func redirectToMain() {
        
//        let mainViewController = MainViewController()
//        self.navigationController?.pushViewController(mainViewController, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView") as! MainViewController
        self.present(mainViewController, animated: true, completion: nil)
    }

}
