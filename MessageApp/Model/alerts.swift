//
//  alerts.swift
//  MessageApp
//
//  Created by Mateusz Łukasiński on 13/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class Alert{
    
    //variables:
    private var title: String
    private var message: String
    private var vc:UIViewController
    
    init(title:String, message:String, in vc:UIViewController) {
        self.title=title
        self.message=message
        self.vc=vc
        show()
    }
    
    private func show(){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
