//
//  AccountViewController.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/3/23.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginRegisterButton: UIButton!
    @IBOutlet weak var switchLoginRegisterButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            switchLoginRegisterButton.setTitle(K.AccText.logout, for: .normal)
        } else {
            switchLoginRegisterButton.setTitle(K.AccText.register, for: .normal)
            loginRegisterButton.setTitle(K.AccText.login, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginRegisterPressed(_ sender: UIButton) {
        // if text blocks are not blank
        if let email = emailTextField.text, let password = passwordTextField.text {
            // if user is in login screen
            if loginRegisterButton.titleLabel?.text == K.AccText.login {
                // login user
                Auth.auth().signIn(withEmail: email, password: password) { authResults, error in
                    if let e = error {
                        self.alertUser(e)
                        self.passwordTextField.text = ""
                    } else {
                        // go back to main screen
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
            
            // if user is in register screen
            else if loginRegisterButton.titleLabel?.text == K.AccText.register {
                // register user
                Auth.auth().createUser(withEmail: email, password: password) { authResults, error in
                    if let e = error {
                        self.alertUser(e)
                        self.passwordTextField.text = ""
                    } else {
                        // go back to main screen
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func switchLoginRegisterPressed(_ sender: UIButton) {
        // if user is in login screen, switch to register screen
        if switchLoginRegisterButton.titleLabel?.text == K.AccText.register {
            // print("Switching to register screen")
            loginRegisterButton.setTitle(K.AccText.register, for: .normal)
            switchLoginRegisterButton.setTitle(K.AccText.login, for: .normal)
        }
        
        // if user is in register screen, switch to login screen
        else if switchLoginRegisterButton.titleLabel?.text == K.AccText.login {
            // print("Switching to login screen")
            loginRegisterButton.setTitle(K.AccText.login, for: .normal)
            switchLoginRegisterButton.setTitle(K.AccText.register, for: .normal)
        }
        
        // if user is logged in, will log out user
        else {
            // print("Attempting sign out")
            do {
                try Auth.auth().signOut()
                // print("User signed out")
                navigationController?.popToRootViewController(animated: true)
            } catch let e as NSError {
                alertUser(e)
            }
        }
    }
    
    func alertUser(_ e: Error) {
        // initialize ok action for error alert
        let ok = UIAlertAction(title: "OK", style: .default)
        
        // pop up alert
        let alert = UIAlertController(title: "Alert", message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
        // print error to console
        print(e)
    }
}
