//
//  WelcomeViewController.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/3/23.
//

import UIKit
import Firebase


class WelcomeViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topRightButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = Auth.auth().currentUser?.email {
            topRightButton.setTitle(user, for: .normal)
            // print("User signed in")
        } else {
            topRightButton.setTitle("Login / Register", for: .normal)
            // print("No user signed in")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "CookSmart"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }

}
