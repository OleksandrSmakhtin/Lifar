//
//  FavoriteVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit

class FavoriteVC: UIViewController {

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Favorite"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }
}
