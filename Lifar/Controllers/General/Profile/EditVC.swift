//
//  EditVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 25/07/2023.
//

import UIKit
import Combine


class EditVC: UIViewController {
    
    //MARK: - viewModel
    var viewModel = EditViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let changeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Change", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        btn.backgroundColor = .black
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 20
        // shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        
        btn.addTarget(self, action: #selector(didTapChangeBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let firstTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "")
        textField.addTarget(self, action: #selector(didFirstFieldTextChanged), for: .editingChanged)
        return textField
    }()
    
    private let secondTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "")
        textField.addTarget(self, action: #selector(didSecondFieldTextChanged), for: .editingChanged)
        return textField
    }()
    
    //MARK: - Actions
    @objc private func didFirstFieldTextChanged() {
        viewModel.firstField = firstTextField.text
        viewModel.validateForm()
    }
    
    @objc private func didSecondFieldTextChanged() {
        viewModel.secondField = secondTextField.text
        viewModel.validateForm()
    }
    
    @objc private func didTapChangeBtn() {
        viewModel.changeData()
        firstTextField.isEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [weak self] in
            self?.changeBtn.layer.opacity = 0
        } completion: { _ in }
    }
    
    @objc private func didTapToDissmiss() {
        view.endEditing(true)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar(for: viewModel.editType)
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retreiveUser()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        
        // error
        viewModel.$error.sink { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            
            self?.changeBtn.backgroundColor = .systemRed
            self?.changeBtn.setTitle("Try again", for: .normal)
            self?.changeBtn.isUserInteractionEnabled = false
            self?.changeBtn.layer.borderColor = UIColor.systemRed.cgColor
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                    self?.changeBtn.layer.opacity = 1
                } completion: { _ in }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                    
                    
                    self?.changeBtn.backgroundColor = .black
                    self?.changeBtn.setTitle("Change", for: .normal)
                    self?.changeBtn.isUserInteractionEnabled = true
                    self?.changeBtn.layer.borderColor = UIColor.black.cgColor
                    
                    self?.changeBtn.layer.opacity = 1
                } completion: { _ in }
            }
            
            
        }.store(in: &subscriptions)
        
        // is changes successful
        viewModel.$isChangesSuccessful.sink { [weak self] state in
            guard let state = state else { return }
            
            if state {
                self?.changeBtn.backgroundColor = .systemGreen
                self?.changeBtn.setTitle("Successful!", for: .normal)
                self?.changeBtn.isUserInteractionEnabled = false
                self?.changeBtn.layer.borderColor = UIColor.systemGreen.cgColor
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                        self?.changeBtn.layer.opacity = 1
                    } completion: { _ in }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self?.navigationController?.popViewController(animated: true)
                }
                
            }
            
        }.store(in: &subscriptions)
        
        // is form valid
        viewModel.$isFormValid.sink { [weak self] state in
            self?.changeBtn.isEnabled = state
        }.store(in: &subscriptions)
        
        // edit type
        viewModel.$editType.sink { [weak self] type in
            switch type {
            case .name:
                self?.firstTextField.isHidden = false
                self?.firstTextField.targetLbl.text = "Name to change"
                self?.secondTextField.isHidden = true
                
            case .email:
                self?.firstTextField.isHidden = false
                self?.firstTextField.targetLbl.text = "Email to change"
                self?.secondTextField.isHidden = false
                self?.secondTextField.targetLbl.text = "Password"
                
            case .password:
                self?.firstTextField.isHidden = false
                self?.firstTextField.targetLbl.text = "Password"
                self?.secondTextField.isHidden = false
                self?.secondTextField.targetLbl.text = "New password"
                
            case .adress:
                self?.firstTextField.isHidden = false
                self?.firstTextField.targetLbl.text = "Adress 1"
                self?.secondTextField.isHidden = false
                self?.secondTextField.targetLbl.text = "Adress 2 (Optional)"
                
            default:
                return
            }
        }.store(in: &subscriptions)
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(changeBtn)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDissmiss)))
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let firstTextFieldConstraints = [
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstTextField.heightAnchor.constraint(equalToConstant: 50),
            firstTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        ]
        
        let secondTextFieldConstraints = [
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondTextField.heightAnchor.constraint(equalToConstant: 50),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 45)
        ]
        
        let changeBtnConstraints = [
            changeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            changeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            changeBtn.heightAnchor.constraint(equalToConstant: 55),
            changeBtn.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(firstTextFieldConstraints)
        NSLayoutConstraint.activate(secondTextFieldConstraints)
        NSLayoutConstraint.activate(changeBtnConstraints)
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar(for title: EditType?) {
        guard let title = title?.rawValue else { return }
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = title
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }


}
