//
//  MainVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit

class MainVC: UIViewController {

    //MARK: - UI Objects
    private let categoriesScrollView = CategoriesScrollView()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakePink
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        //UserDefaults.standard.set(false, forKey: "isOnboarded")
        //
        
        
        if !UserDefaults.standard.bool(forKey: "isOnboarded") {
            let vc = UINavigationController(rootViewController: FirstWelcomeVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Liraf"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .cakeWhite
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        navigationController?.navigationBar.tintColor = .cakeWhite
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: nil)
        
        navigationItem.titleView = lifarLbl
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(categoriesScrollView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let categoriesScrollViewConstraints = [
            categoriesScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            categoriesScrollView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(categoriesScrollViewConstraints)
    }

}
