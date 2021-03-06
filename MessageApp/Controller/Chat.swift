//
//  Chat.swift
//  MessageApp
//
//  Created by Mateusz Łukasiński on 13/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import ChameleonFramework

class Chat: UIViewController {

    //variables:
    
    var messagesArray:[messageClass] = [messageClass]()
    
    //IBOutlets:
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var textViewHeight:NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    
    //IBActions
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        logOut()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        messageEditingEnded()
        
        messagesTextField.isEnabled=false
        sendButton.isEnabled=false
        
        let messagesDataBase = Database.database().reference().child("messages")
        let mesdict = ["Sender": Auth.auth().currentUser?.email, "MessageBody" : messagesTextField.text]
        
        messagesDataBase.childByAutoId().setValue(mesdict) { (error, reference) in
            if error != nil {
                print(error!.localizedDescription)
                Alert.init(title: "Error", message: error!.localizedDescription, in: self)
                self.messagesTextField.isEnabled=true
                self.sendButton.isEnabled=true
            }
            
            else{
                print("Message sent successfully")
                self.messagesTextField.isEnabled=true
                self.sendButton.isEnabled=true
                self.messagesTextField.text=""
            }
        }
    }
    
    
    
    //Functions:
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.delegate=self
        messagesTableView.dataSource=self
        messagesTextField.delegate=self
        messagesTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        let tapRegistered = UITapGestureRecognizer(target: self, action: #selector(messageEditingEnded))
        messagesTableView.addGestureRecognizer(tapRegistered)
        changeCellHeight()
        getMessage()
        messagesTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    

    func getMessage(){
        
        let messagesDataBase = Database.database().reference().child("messages")
        
        messagesDataBase.observe(.childAdded) { (temp) in
            let temp = temp.value as! Dictionary<String,String>
            
            let user = temp["Sender"]!
            let text = temp["MessageBody"]!
            
            let message = messageClass.init(user: user, message: text)
            self.messagesArray.append(message)
            self.changeCellHeight()
            self.messagesTableView.reloadData()
        }
        
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
            Alert.init(title: "Error", message: error.localizedDescription, in: self)
        }
    }
}

//tableView stuff:
extension Chat: UITableViewDelegate, UITableViewDataSource{
    
    func changeCellHeight(){
//        messagesTableView.rowHeight = UITableView.automaticDimension
//        messagesTableView.estimatedRowHeight = 120.0
        messagesTableView.rowHeight=120.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! MessageCell
        
//        let testArray:[String] = ["test1","test2","test3"]
//        cell.messageLabel.text=testArray[indexPath.row]
        
        cell.messageLabel.text = messagesArray[indexPath.row].message
        cell.nameLabel.text = messagesArray[indexPath.row].user
        cell.avatarImage.image = UIImage(named: "man")
        
        if cell.nameLabel.text == Auth.auth().currentUser?.email{
            cell.avatarImage.backgroundColor = UIColor.flatBlue()
        }
        else{
            cell.avatarImage.backgroundColor=UIColor.flatRed()
        }
        return cell
    }
    
    @objc func messageEditingEnded(){
        messagesTextField.endEditing(true)
    }
    
}

//message TextField Stuff:
extension Chat: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.textViewHeight.constant = 265+50
            self.view.layoutIfNeeded() // refreshes layout
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.textViewHeight.constant = 50
            self.view.layoutIfNeeded() // refreshes layout
        }
    }
    
}
