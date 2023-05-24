//
//  MainVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit

class MainVC: UIViewController {
    
    
    let isUserOnboarded = false

    //MARK: - UI Objects
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakePink
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isUserOnboarded {
            let vc = UINavigationController(rootViewController: FirstWelcomeVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    
    
    //MARK: - Add subviews
    private func addSubviews() {
    }

}
