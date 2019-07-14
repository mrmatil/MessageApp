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
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messagesTextField: UITextField!
    @IBOutlet weak var textViewHeight:NSLayoutConstraint!
    
    
    //IBActions
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        logOut()
    }
    
    
    
    //Functions:
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.delegate=self
        messagesTableView.dataSource=self
        messagesTextField.delegate=self
        messagesTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        let tapRegistered = UITapGestureRecognizer(target: self, action: #selector(tableViewTap))
        messagesTableView.addGestureRecognizer(tapRegistered)
        changeCellHeight()
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

//tableView stuff:
extension Chat: UITableViewDelegate, UITableViewDataSource{
    
    func changeCellHeight(){
//        messagesTableView.rowHeight = UITableView.automaticDimension
//        messagesTableView.estimatedRowHeight = 120.0
        messagesTableView.rowHeight=120.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! MessageCell
        
        let testArray:[String] = ["test1","test2","test3"]
        cell.messageLabel.text=testArray[indexPath.row]
        return cell
    }
    
    @objc func tableViewTap(){
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
