//
//  SecondWelcomeVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit

class SecondWelcomeVC: UIViewController {

    //MARK: - UI Objects
    private let welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "BEST DESSERTS IN"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lifarLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "IRELAND"
        lbl.font = UIFont(name: "Chalkboard SE", size: 30)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Here you can easily and conveniently order cake and other desserts for any special moment in your life."
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 1
        pageControl.numberOfPages = 2
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .black.withAlphaComponent(0.5)
        pageControl.addTarget(self, action: #selector(didChangePage(_:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var rightSwipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .right
        swipe.numberOfTouchesRequired = 1
        swipe.addTarget(self, action: #selector(swipedToRight))
        return swipe
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
        
        btn.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Sign Up", for: .normal)
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
        
        btn.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakeWhite
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageControl.currentPage = 1
        navigationController?.navigationBar.tintColor = .cakeWhite
//        guard let rootVC = navigationController?.topViewController as? FirstWelcomeVC else { return }
//        rootVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    //MARK: - Actions
    @objc private func didTapLogIn() {
        let vc = LogInVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didChangePage(_ sender: UIPageControl) {
        if sender.currentPage == 0 {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func swipedToRight() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addGestureRecognizer(rightSwipe)
        view.addSubview(logInBtn)
        view.addSubview(signUpBtn)
        view.addSubview(pageControl)
        view.addSubview(welcomeLbl)
        view.addSubview(lifarLbl)
        view.addSubview(descriptionLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let logInBtnConstraints = [
            logInBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logInBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 35),
            logInBtn.heightAnchor.constraint(equalToConstant: 60),
            logInBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        let signUpBtnConstraints = [
            signUpBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 35),
            signUpBtn.heightAnchor.constraint(equalToConstant: 60),
            signUpBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: logInBtn.topAnchor, constant: -10)
        ]
        
        let welcomeLblConstraints = [
            welcomeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let lifarLblConstraints = [
            lifarLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lifarLbl.topAnchor.constraint(equalTo: welcomeLbl.bottomAnchor, constant: 10)
        ]
        
        let descriptionLblConstraints = [
            descriptionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descriptionLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            descriptionLbl.topAnchor.constraint(equalTo: lifarLbl.bottomAnchor, constant: 40)
        ]
        
        NSLayoutConstraint.activate(logInBtnConstraints)
        NSLayoutConstraint.activate(signUpBtnConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
        NSLayoutConstraint.activate(welcomeLblConstraints)
        NSLayoutConstraint.activate(lifarLblConstraints)
        NSLayoutConstraint.activate(descriptionLblConstraints)
    }

}
