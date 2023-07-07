//
//  ItemVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 06/07/2023.
//

import UIKit
import Combine

class ItemVC: UIViewController {
    
    //MARK: - viewModel
    private(set) var viewModel = ItemViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        scrollView.backgroundColor = .cakeWhite
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        //view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.backgroundColor = .white
        //imageView.clipsToBounds = true
        
        // shadow
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowRadius = 4
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        // configure nav bar
        configureNavBar()
        // bind views
        bindViews()
        // apply delegates
        applyScrollViewDelegate()
        
    }
    
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$item.sink { [weak self] item in
            guard let item = item else { return }
            print(item.title)
            print(item.price)
            self?.productImageView.sd_setImage(with: URL(string: item.path))
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(topSeparatorView)
        view.addSubview(scrollView)
        scrollView.addSubview(imageContainerView)
        imageContainerView.addSubview(productImageView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let topSeparatorViewConstraints = [
            topSeparatorView.topAnchor.constraint(equalTo: view.topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let imageContainerViewConstraints = [
            imageContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageContainerView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let productImageViewConstraints = [
            productImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            //productImageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            productImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            //productImageView.heightAnchor.constraint(equalToConstant: 100),
            //productImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(imageContainerViewConstraints)
        NSLayoutConstraint.activate(productImageViewConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: nil)
    }
    
}

//MARK: - UIScrollViewDelegate
extension ItemVC: UIScrollViewDelegate {
    
    private func applyScrollViewDelegate() {
        scrollView.delegate = self
    }
    
    // did scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yPosition = scrollView.contentOffset.y
        
        if yPosition < 0 {
            scrollView.contentOffset.y = 0
        }
        
    }
    
}
