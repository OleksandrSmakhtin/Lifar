//
//  SecondWelcomeVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit

class SecondWelcomeVC: UIViewController {

    //MARK: - UI Objects
    private let getStartedBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .cakeWhite
        btn.tintColor = .cakeFuchsia
        btn.setTitle("GET STARTED", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.layer.cornerRadius = 30
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakePink
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(getStartedBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let getStartedBtnConstraints = [
            getStartedBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            getStartedBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            getStartedBtn.heightAnchor.constraint(equalToConstant: 60),
            getStartedBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        NSLayoutConstraint.activate(getStartedBtnConstraints)
    }

}
