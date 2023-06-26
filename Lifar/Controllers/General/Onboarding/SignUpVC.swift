//
//  SignUpVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit
import Combine

class SignUpVC: UIViewController {
    
    //MARK: - ViewModel
    private var viewModel = AuthViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let nameTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "Name")
        textField.addTarget(self, action: #selector(didChangeName), for: .editingChanged)
        return textField
    }()
    
    private let loginTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "E-mail")
        textField.addTarget(self, action: #selector(didChangeEmail), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "Password")
        textField.addTarget(self, action: #selector(didChangePassword), for: .editingChanged)
        return textField
    }()
    
    private let repeatPasswordTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "Repeat password")
        textField.addTarget(self, action: #selector(didChangeRepeatPassword), for: .editingChanged)
        return textField
    }()
    
    private let signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setTitle("Sign Up", for: .normal)
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
          
        // is enable
        btn.isEnabled = false
        
        btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapToDissmiss() {
        view.endEditing(true)
    }
    
    @objc private func didChangeName() {
        viewModel.name = nameTextField.text
        viewModel.validateSignUpForm()
    }
    
    @objc private func didChangeEmail() {
        viewModel.email = loginTextField.text
        viewModel.validateSignUpForm()
    }
    
    @objc private func didChangePassword() {
        viewModel.password = passwordTextField.text
        viewModel.validateSignUpForm()
    }
    
    @objc private func didChangeRepeatPassword() {
        viewModel.repeatedPassword = repeatPasswordTextField.text
        viewModel.validateSignUpForm()
    }

    @objc private func didTapSignUp() {
        viewModel.signUpUser()
    }
    
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
        // bind views
        bindViews()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        
        // is auth form valid
        viewModel.$isAuthFormValid.sink { [weak self] state in
            self?.signUpBtn.isEnabled = state
        }.store(in: &subscriptions)
        
        
        // auth binding
        viewModel.$user.sink { [weak self] user in
            guard user != nil else { return }
            guard let vc = self?.navigationController?.viewControllers.first as? FirstWelcomeVC else { return }
            vc.dismiss(animated: true)
        }.store(in: &subscriptions)
        
        
        // error binding
        viewModel.$error.sink { [weak self] error in
            guard let error = error else { return }
            self?.presentAlert(with: error)
        }.store(in: &subscriptions)
        
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(nameTextField)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(signUpBtn)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDissmiss)))
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let nameTextFieldConstraints = [
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        ]
        
        let loginTextFieldConstraints = [
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            loginTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 45)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 45)
        ]
        
        let repeatPasswordTextFieldConstraints = [
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 45)
        ]
        
        let logInBtnConstraints = [
            signUpBtn.heightAnchor.constraint(equalToConstant: 60),
            signUpBtn.centerXAnchor.constraint(equalTo: repeatPasswordTextField.centerXAnchor),
            signUpBtn.widthAnchor.constraint(equalToConstant: 200),
            signUpBtn.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 30)
        ]
        
        NSLayoutConstraint.activate(nameTextFieldConstraints)
        NSLayoutConstraint.activate(loginTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(repeatPasswordTextFieldConstraints)
        NSLayoutConstraint.activate(logInBtnConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Sign Up"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }
    
    //MARK: - Present alert
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(errorAction)
        present(alert, animated: true)
    }

}
