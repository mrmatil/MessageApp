//
//  Messages.swift
//  MessageApp
//
//  Created by Mateusz Łukasiński on 14/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation

class messageClass{
    
    init(user:String,message:String){
        self.user=user
        self.message=message
    }
    
    var user: String = ""
    var message: String = "" 
}
