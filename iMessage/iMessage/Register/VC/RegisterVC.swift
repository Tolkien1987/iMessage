//
//  RegisterVC.swift
//  viewCode_App
//
//  Created by Fabio Martinez on 02/03/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    var registerScreen: RegisterScreen?
    
    var auth:Auth?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelagate(delagate: self)
        self.registerScreen?.delagete(delegate: self)
        self.auth = Auth.auth()
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Firebase Auth

extension RegisterVC: RegisterScreenProtocol {
    func actionRegisterButton() {
        
        guard let register = self.registerScreen else {return}
    
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { (result, error) in
            
            if error != nil {
                print("Authentication Error :( ")
            } else {
                print("Success :) !")
            }
        })
    }
}
