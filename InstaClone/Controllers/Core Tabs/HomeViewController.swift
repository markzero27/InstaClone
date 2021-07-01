//
//  ViewController.swift
//  InstaClone
//
//  Created by Marcus Daquis on 6/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check Auth status
        
        if let user = Auth.auth().currentUser  {
            print(user.email!)
        } else {
            // not logged in, redirect to login page
             performSegue(withIdentifier: "HomeToLogin", sender: self)
        }
        
    }

}

