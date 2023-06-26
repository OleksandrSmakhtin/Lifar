//
//  LogInVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit
import Combine

class LogInVC: UIViewController {
    
    //MARK: - Data
    private var viewModel = AuthViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let loginTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "E-mail")
        textField.addTarget(self, action: #selector(didChangeLogin), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "Password")
        textField.addTarget(self, action: #selector(didChangePassword), for: .editingChanged)
        return textField
    }()
    
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
        
        btn.isEnabled = false
        
        btn.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapToDissmiss() {
        view.endEditing(true)
    }
    
    @objc private func didChangeLogin() {
        viewModel.email = loginTextField.text
        viewModel.validateLogInForm()
    }
    
    @objc private func didChangePassword() {
        viewModel.password = passwordTextField.text
        viewModel.validateLogInForm()
    }
    
    @objc private func didTapLogIn() {
        viewModel.loginUser()
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
        
        // user binding
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
        
        // is btn enabled
        viewModel.$isAuthFormValid.sink { [weak self] state in
            self?.logInBtn.isEnabled = state
        }.store(in: &subscriptions)
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInBtn)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDissmiss)))
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let loginTextFieldConstraints = [
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
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
    
    //MARK: - Present alert
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let errorAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(errorAction)
        present(alert, animated: true)
    }

}
