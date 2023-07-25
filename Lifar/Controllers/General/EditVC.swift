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
    private var subscription: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let firstTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "")
        //textField.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return textField
    }()
    
    private let secondTextField: CustomTextField = {
        let textField = CustomTextField(frame: .zero, target: "")
        //textField.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return textField
    }()
    
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
    
    //MARK: - Bind views
    private func bindViews() {
        
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
                self?.secondTextField.targetLbl.text = "Repeat new email"
                
            case .password:
                self?.firstTextField.isHidden = false
                self?.firstTextField.targetLbl.text = "Password to change"
                self?.secondTextField.isHidden = false
                self?.secondTextField.targetLbl.text = "Repeat new password"
                
            case .adress:
                self?.firstTextField.isHidden = false
                self?.firstTextField.targetLbl.text = "Adress 1"
                self?.secondTextField.isHidden = false
                self?.secondTextField.targetLbl.text = "Adress 2"
                
            default:
                return
            }
        }.store(in: &subscription)
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
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
        
        NSLayoutConstraint.activate(firstTextFieldConstraints)
        NSLayoutConstraint.activate(secondTextFieldConstraints)
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
