//
//  RegisterScreen.swift
//  iMessage
//
//  Created by Fabio Martinez on 06/03/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    weak private var delegate: RegisterScreenProtocol?
    
    func delagete(delegate: RegisterScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFill
        image.alpha = 1
        return image
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.placeholder = "Type your e-mail"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.placeholder = "Type your password"
        textField.isSecureTextEntry = true 
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemMint
        button.setTitle("Register!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Make with ❤️ in Brazil!"
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configSuperView()
        self.configBackground()
        self.setUpConstraints()
        self.configButtonEnable(false)
    }
    
    //MARK: Methods
    
    private func configBackground() {
        self.backgroundColor = UIColor(red: 208/255, green: 228/255, blue: 240/255, alpha: 1.0)
    }
    
    public func configTextFieldDelagate(delagate: UITextFieldDelegate) {
        self.emailTextField.delegate = delagate
        self.passwordTextField.delegate = delagate
    }
    
    @objc private func tappedRegisterButton() {
        self.delegate?.actionRegisterButton()
    }
    
    public func validateTextFields() {
        
        let email:String = self.emailTextField.text ?? ""
        let password:String = self.passwordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty {
            self.configButtonEnable(true)
        } else {
            self.configButtonEnable(false)
        }
    }
    
    private func configButtonEnable(_ enable: Bool) {
        if enable {
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
        } else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
        }
    }
    
    public func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    public func getPassword() -> String {
        return self.passwordTextField.text ?? ""
    }
    
    private func configSuperView() {
        self.addSubview(self.logoImageView)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.registerButton)
        self.addSubview(self.bottomLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            self.logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150),
            self.logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 80),
            self.emailTextField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 50),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
            self.registerButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10),
            self.registerButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.registerButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.registerButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
            self.bottomLabel.topAnchor.constraint(equalTo: self.registerButton.bottomAnchor, constant: 180),
            self.bottomLabel.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.bottomLabel.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),

        ])
    }
    
}
