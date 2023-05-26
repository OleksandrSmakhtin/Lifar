//
//  CategoriesScrollView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 26.05.2023.
//

import UIKit

class CategoriesScrollView: UIView {
    
    var selectedTabIndex = 0

    private let categories = ["Wedding cakes", "Celebration & Bithday", "TARTS", "Cupcakes", "Cupcakes", "Desserts", "Macarons"]
    
    private lazy var tabTapGesture: UITapGestureRecognizer = {
        let gest = UITapGestureRecognizer()
        gest.numberOfTapsRequired = 1
        gest.addTarget(self, action: #selector(didSelectTab(_:)))
        return gest
    }()
    
    private lazy var tabs: [UIView] = ["Wedding cakes", "Celebration & Bithday", "TARTS", "Cupcakes", "Cupcakes", "Desserts", "Macarons"].map { title in
        let view = CategoryView()
        //guard let title = title as? String else { return UILabel() }
        view.setTitle(title: title)
        view.addGestureRecognizer(tabTapGesture)
        return view
    }
    
    private lazy var tabsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // enable constraints
        translatesAutoresizingMaskIntoConstraints = false
        tabTapGesture.addTarget(self, action: #selector(didSelectTab(_:)))
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didSelectTab(_ sender: CategoryView) {
        print(sender.titleLbl.text)
        print("PUPA")
    }
    
    //MARK: - Configure first look
    private func configureFirstLook() {
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(tabsStack)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let tabsStackConstraints = [
            tabsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            tabsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            tabsStack.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ]
        
        for tab in tabs {
            NSLayoutConstraint.activate([
                tab.topAnchor.constraint(equalTo: scrollView.topAnchor),
                tab.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                tab.widthAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(tabsStackConstraints)
        
    }
    

}

