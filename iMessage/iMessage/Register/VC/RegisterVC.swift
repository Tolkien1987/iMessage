//
//  RegisterVC.swift
//  iMessage
//
//  Created by Fabio Martinez on 06/03/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    var registerScreen: RegisterScreen?
    var alert: Alert?
    var auth:Auth?
    var firestore:Firestore?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelagate(delagate: self)
        self.registerScreen?.delagete(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
        self.firestore = Firestore.firestore()
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
                self.alert?.getAlert(titulo: "Atenção", mensagem: "Erro ao cadastrar, verique os dados e tente novamente")
            } else {
                
                //MARK: Save data on Firebase
                
                if let idUsuario = result?.user.uid {
                    self.firestore?.collection("usuarios").document(idUsuario).setData([
                        "nome":self.registerScreen?.getName() ?? "",
                        "email":self.registerScreen?.getEmail() ?? "",
                        "id":idUsuario
                    ])
                }
                
                self.alert?.getAlert(titulo: "Parabéns", mensagem: "Usuario cadastrado com sucesso", completion: {
                    let VC = HomeVC()
                    let navVC = UINavigationController(rootViewController: VC)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true, completion: nil)
                })
            }
        })
    }
}

