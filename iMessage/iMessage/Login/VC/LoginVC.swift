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
    var alert: Alert?
    var loginScreen: LoginScreen?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.alert = Alert(controller: self)
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
                self.alert?.getAlert(titulo: "Atenção", mensagem: "Atenção dados incorretos, verifique e tente novamente")
            } else {
                if usuario == nil {
                    self.alert?.getAlert(titulo: "Atenção", mensagem: "Tivemos um problema inesperado, tente novamente mais tarde")
                } else {
                    self.alert?.getAlert(titulo: "Parabens", mensagem: "Usuario logado com sucesso!")
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
