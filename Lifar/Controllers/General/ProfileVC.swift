//
//  ProfileVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 20.06.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileVC: UIViewController {

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Profile"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward.square.fill"), style: .plain, target: self, action: #selector(didTapSignOut))
    }
    
    //MARK: - Actions
    @objc private func didTapSignOut() {
        
        try? Auth.auth().signOut()
        navigationController?.popViewController(animated: false)
    }

}
