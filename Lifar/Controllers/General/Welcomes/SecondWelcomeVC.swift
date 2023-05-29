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
        lbl.textColor = .cakeWhite
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lifarLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "IRELAND"
        lbl.font = UIFont(name: "Chalkboard SE", size: 30)
        lbl.textColor = .cakeWhite
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Here you can easily and conveniently order cake and other desserts for any special moment in your life."
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .cakeWhite
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 1
        pageControl.numberOfPages = 2
        pageControl.currentPageIndicatorTintColor = .cakeWhite
        pageControl.pageIndicatorTintColor = .cakeWhite?.withAlphaComponent(0.5)
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
    
    private let getStartedBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .cakeWhite
        btn.tintColor = .cakeFuchsia
        btn.setTitle("GET STARTED", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
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
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageControl.currentPage = 1
    }
    
    //MARK: - Actions
    @objc private func didTapGetStarted() {
        guard let controller = navigationController?.viewControllers.first as? FirstWelcomeVC else { return }
        UserDefaults.standard.set(true, forKey: "isOnboarded")
        controller.dismiss(animated: true)
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
        view.addSubview(getStartedBtn)
        view.addSubview(pageControl)
        view.addSubview(welcomeLbl)
        view.addSubview(lifarLbl)
        view.addSubview(descriptionLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let getStartedBtnConstraints = [
            getStartedBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            getStartedBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            getStartedBtn.heightAnchor.constraint(equalToConstant: 60),
            getStartedBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: getStartedBtn.topAnchor, constant: -10)
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
        
        NSLayoutConstraint.activate(getStartedBtnConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
        NSLayoutConstraint.activate(welcomeLblConstraints)
        NSLayoutConstraint.activate(lifarLblConstraints)
        NSLayoutConstraint.activate(descriptionLblConstraints)
    }

}
