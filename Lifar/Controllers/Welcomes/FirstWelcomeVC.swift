//
//  FirstWelcomeVCViewController.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit

class FirstWelcomeVC: UIViewController {
    
    //MARK: - UI Objects
    private lazy var swipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .left
        swipe.numberOfTouchesRequired = 1
        swipe.addTarget(self, action: #selector(swipedToRight))
        return swipe
    }()
    
    private let nextBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .cakeWhite
        btn.tintColor = .cakeFuchsia
        btn.setTitle("NEXT", for: .normal)
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
    
    //MARK: - Actions
    @objc private func swipedToRight() {
        let vc = SecondWelcomeVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addGestureRecognizer(swipe)
        view.addSubview(nextBtn)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {

        let nextBtnConstraints = [
            nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextBtn.heightAnchor.constraint(equalToConstant: 60),
            nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        NSLayoutConstraint.activate(nextBtnConstraints)
        
    }


}
