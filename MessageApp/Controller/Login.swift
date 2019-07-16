//
//  Login.swift
//  MessageApp
//
//  Created by Mateusz Łukasiński on 13/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class Login: UIViewController {

    //IBOutlets:
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //IBActions:
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if let error = error{
                print("Error: \(error.localizedDescription)")
                Alert.init(title: "Error", message: error.localizedDescription, in: self)
            }
            
            else{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "LoginChat", sender: self)
            }
        }
        
    }
    
    
    //Functions:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
