//
//  LoginViewController.swift
//  InstaClone
//
//  Created by Marcus Daquis on 6/11/21.
//

import SafariServices
import UIKit


class LoginViewController: UIViewController {
  
    // Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Properties
    var databaseManager = DatabaseManager()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.shared.delegate = self
    }
    
    // MARK: - IBActions

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        if let usernameEmail = usernameField.text, let password = passwordField.text {
  
            if !usernameEmail.isEmpty || !password.isEmpty || password.count >= 6 {
                // will try to login
                var username: String?
                var email: String?
                
                if usernameEmail.contains("@"), usernameEmail.contains(".") {
                    // email
                    email = usernameEmail
                } else {
                    // username
                    username = usernameEmail
                }
                
                AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
                    print("\(success) success")
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Login error", message: "Autentication failed!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func didTapTermsAndCondition(_ sender: UIButton) {
        if let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") {
            let vc = SFSafariViewController(url: url)
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
  
            present(vc, animated: true)
        }
      
    }
}

extension LoginViewController: DatabaseManagerDelegate {
    func didCreateUser(username: String, password: String) {
        print(username)
        print(password)
        DispatchQueue.main.async {
            self.usernameField.text = username
            self.passwordField.text = password
        }
    }
}
