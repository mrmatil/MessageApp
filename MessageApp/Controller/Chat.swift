//
//  Chat.swift
//  MessageApp
//
//  Created by Mateusz Łukasiński on 13/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class Chat: UIViewController {

    //IBOutlets:
    
    
    //IBActions
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        logOut()
    }
    
    
    
    //Functions:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}


//logging out :
import Firebase
extension Chat{
    func logOut(){
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
        } catch  {
            print(error.localizedDescription)
        }
    }
}
