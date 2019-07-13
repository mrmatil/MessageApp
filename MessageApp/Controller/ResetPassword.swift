//
//  ResetPassword.swift
//  MessageApp
//
//  Created by Mateusz Łukasiński on 13/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class ResetPassword: UIViewController {


    //IBOutlets:
    @IBOutlet weak var emailTextField: UITextField!
    
    
    //IBFunctions:
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        reset()
    }
    
    
    //functions:
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}

import Firebase
extension ResetPassword{
    func reset(){
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            
            if let error = error{
                print(error.localizedDescription)
                Alert.init(title: "Error", message: error.localizedDescription, in: self)
            }
            else{
                print("Password reset")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
