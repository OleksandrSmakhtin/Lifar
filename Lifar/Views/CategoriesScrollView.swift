//
//  CategoriesScrollView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 26.05.2023.
//

import UIKit

enum CategoriesTabs: String {
    case wedding = "Wedding cakes"
    case celebration = "Celebration & Bithday"
    case tarts = "TARTS"
    case cupcakes = "Cupcakes"
    case miniCupcakes = "Mini cupcakes"
    case desserts = "Desserts"
    case macarons = "Macarons"
}

class CategoriesScrollView: UIView {
    
    var selectedTabIndex = 0 {
        didSet {
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.tabs[i].deselectTab()
                    self?.layoutIfNeeded()
                } completion: { _ in }
            }
            
            //scrollView.setContentOffset(CGPoint(x: tabs[selectedTabIndex].frame.origin.x - 100, y: 0), animated: true)
        }
    }

    private let categories = ["Wedding cakes", "Celebration & Bithday", "TARTS", "Cupcakes", "Cupcakes", "Desserts", "Macarons"]
    
    private lazy var tabs: [CategoryView] = ["Wedding cakes", "Celebration & Bithday", "TARTS", "Cupcakes", "Mini cupcakes", "Desserts", "Macarons"].map { title in
        let view = CategoryView()
        view.setTitle(title: title)
        view.delegate = self
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
        configureFirstLook()
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    //MARK: - Configure first look
    private func configureFirstLook() {
        tabs[0].selectTab()
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
            ])
        }
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(tabsStackConstraints)
        
    }
    

}

//MARK: - CategoryViewDelegate
extension CategoriesScrollView: CategoryViewDelegate {
    func didTapTab(with title: String) {
        switch title {
        case CategoriesTabs.wedding.rawValue:
            selectedTabIndex = 0
        case CategoriesTabs.celebration.rawValue:
            selectedTabIndex = 1
        case CategoriesTabs.tarts.rawValue:
            selectedTabIndex = 2
        case CategoriesTabs.cupcakes.rawValue:
            selectedTabIndex = 3
        case CategoriesTabs.miniCupcakes.rawValue:
            selectedTabIndex = 4
        case CategoriesTabs.desserts.rawValue:
            selectedTabIndex = 5
        case CategoriesTabs.macarons.rawValue:
            selectedTabIndex = 6
        default:
            selectedTabIndex = 0
        }
        tabs[selectedTabIndex].layer.borderWidth = 2
        tabs[selectedTabIndex].layer.borderColor = UIColor.cakeFuchsia?.cgColor
        tabs[selectedTabIndex].selectTab()
    }
    
}
