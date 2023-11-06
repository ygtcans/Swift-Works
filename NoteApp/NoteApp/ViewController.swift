//
//  ViewController.swift
//  NoteApp
//
//  Created by Yiğitcan Dursun on 30.10.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        if let name = storedName as? String {
            nameLabel.text = "Name: \(name)"
        }else{
            nameLabel.text = "Geçersiz İfade"
        }
        if let birthday = storedBirthday as? String {
            birthdayLabel.text = "Birthday: \(birthday)"
        }else{
            nameLabel.text = "Geçersiz İfade"
        }
        
    }
     
    @IBAction func saveButton(_ sender: Any) {
        UserDefaults.standard.setValue(nameTextField.text, forKey: "name")
        UserDefaults.standard.setValue(birthdayTextField.text, forKey: "birthday")
        
        nameLabel.text = "Name: \(nameTextField.text!)"
        birthdayLabel.text = "Birthday: \(birthdayTextField.text!)"
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let storedName =  UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if (storedName as? String) != nil{
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name: "
        }
        if (storedBirthday as? String) != nil{
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Birthday: "
        }
        
        
    }
    
}

