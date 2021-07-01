//
//  RegistrationViewController.swift
//  InstaClone
//
//  Created by Marcus Daquis on 6/11/21.
//

import UIKit



class RegistrationViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        guard let username = usernameField.text, !username.isEmpty, let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty,  let password2 = confirmPasswordField.text, !password2.isEmpty else {
            return
        }
        
        guard password == password2 else {
            let alert = UIAlertController(title: "Error", message: "Password did not match!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { success in
            print(success)
            if (success) {
                self.dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Unknown error!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
}
