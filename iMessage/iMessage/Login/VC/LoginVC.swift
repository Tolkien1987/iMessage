//
//  ViewController.swift
//  iMessage
//
//  Created by Fabio Martinez on 06/03/22.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var auth: Auth?

    var loginScreen: LoginScreen?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
}

extension LoginVC: LoginScreenProtocol {
    func actionLoginButton() {

        guard let login = self.loginScreen else {return}
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (usuario, error) in
            
            if error != nil {
                print("Incorrect data input, please check and try again!")
            } else {
                if usuario == nil {
                    print("Internal problem, try again later, please!")
                } else {
                    print("Login successful! Yeah! ")
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let vc:RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
