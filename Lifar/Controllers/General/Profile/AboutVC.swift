//
//  AboutVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 20.06.2023.
//

import UIKit

class AboutVC: UIViewController {
    
    //MARK: - UI Objects
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .cakeWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "  Introducing Liraf: The Ultimate Dessert Ordering App!\n\n  Liraf is a revolutionary mobile application designed to satisfy your sweet tooth cravings with just a few taps. Whether you're in the mood for a delectable cake, a mouthwatering dessert, or want to create your own custom treat, Liraf has you covered.\n\n  With an intuitive and user-friendly interface, Liraf allows you to explore a vast menu of delectable options. From classic chocolate cakes to trendy artisanal desserts, you'll find an extensive range of flavors, styles, and sizes to suit every occasion and preference."
        
        textView.font = UIFont(name: "Futura", size: 18)
        textView.backgroundColor = .cakeWhite
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(topSeparatorView)
        view.addSubview(descriptionTextView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let topSeparatorViewConstraints = [
            topSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSeparatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let descriptionTextViewConstraints = [
            descriptionTextView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(descriptionTextViewConstraints)
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "About"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }
    
    
}
