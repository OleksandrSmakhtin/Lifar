//
//  LogInVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit

class LogInVC: UIViewController {
    
    //MARK: - UI Objects
    private let loginTextField = CustomTextField(frame: .zero, target: "E-mail")
    
    private let passwordTextField = CustomTextField(frame: .zero, target: "Password")
    
    private let logInBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setTitle("Log In", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        btn.backgroundColor = .cakeWhite
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 20
        // shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        
        //btn.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let loginTextFieldConstraints = [
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 60),
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 55)
        ]
        
        let logInBtnConstraints = [
            logInBtn.heightAnchor.constraint(equalToConstant: 60),
            logInBtn.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            logInBtn.widthAnchor.constraint(equalToConstant: 200),
            logInBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
        ]
        
        NSLayoutConstraint.activate(loginTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(logInBtnConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Log In"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }


}
