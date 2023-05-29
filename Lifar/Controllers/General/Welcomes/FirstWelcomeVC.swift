//
//  FirstWelcomeVCViewController.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit

class FirstWelcomeVC: UIViewController {
    
    //MARK: - UI Objects
    private let welcomeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "WELCOME TO"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        lbl.textColor = .cakeWhite
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lifarLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Liraf"
        lbl.font = UIFont(name: "Chalkboard SE", size: 30)
        lbl.textColor = .cakeWhite
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "We invite you to the world of delicious and unique desserts."
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .cakeWhite
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.currentPageIndicatorTintColor = .cakeWhite
        pageControl.pageIndicatorTintColor = .cakeWhite?.withAlphaComponent(0.5)
        pageControl.addTarget(self, action: #selector(didChangePage(_:)), for: .valueChanged)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private lazy var leftSwipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .left
        swipe.numberOfTouchesRequired = 1
        swipe.addTarget(self, action: #selector(swipedToLeft))
        return swipe
    }()
    
    private let nextBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .cakeWhite
        btn.tintColor = .cakeFuchsia
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        btn.layer.cornerRadius = 30
        btn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // nav bar tint
        navigationController?.navigationBar.tintColor = .cakeWhite
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
        pageControl.currentPage = 0
    }
    
    //MARK: - Actions
    @objc private func didChangePage(_ sender: UIPageControl) {
        if sender.currentPage == 1 {
            let vc = SecondWelcomeVC()
            navigationController?.pushViewController(vc, animated: true)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
    
    @objc private func didTapNext() {
        let vc = SecondWelcomeVC()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc private func swipedToLeft() {
        let vc = SecondWelcomeVC()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addGestureRecognizer(leftSwipe)
        view.addSubview(nextBtn)
        view.addSubview(welcomeLbl)
        view.addSubview(lifarLbl)
        view.addSubview(descriptionLbl)
        view.addSubview(pageControl)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {

        let nextBtnConstraints = [
            nextBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextBtn.heightAnchor.constraint(equalToConstant: 60),
            nextBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
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
        
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(nextBtnConstraints)
        NSLayoutConstraint.activate(welcomeLblConstraints)
        NSLayoutConstraint.activate(lifarLblConstraints)
        NSLayoutConstraint.activate(descriptionLblConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
        
    }


}
