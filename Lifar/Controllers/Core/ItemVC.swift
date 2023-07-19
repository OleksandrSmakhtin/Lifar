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
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let callUsView: CallUsView = {
        let view = CallUsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        //lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let buyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Buy", for: .normal)
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
        
        btn.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let minusValueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(didMinusValueBtnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let plusValueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(didPlusValueBtnPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let valueLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 28)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
    
    //MARK: - Actions
    @objc private func didMinusValueBtnPressed() {
        viewModel.minusValue()
        viewModel.validateValue()
        viewModel.calculatePrice(isPlusOperation: false)
    }
    
    @objc private func didPlusValueBtnPressed() {
        viewModel.plusValue()
        viewModel.validateValue()
        viewModel.calculatePrice(isPlusOperation: true)
    }
    
    @objc private func didPressAddToFavorite() {
        viewModel.addToFavotites()
        viewModel.getAndCheckUserFavorites()
    }
    
    @objc private func didTapBuy() {
        viewModel.addToBasket()
        viewModel.checkBasket()
    }
    
    @objc private func didTapGoToBasket() {
        let vc = BasketVC()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
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
    
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .white
        viewModel.getAndCheckUserFavorites()
        viewModel.checkBasket()
    }
    
    
    //MARK: - Bind views
    private func bindViews() {
        // item
        viewModel.$item.sink { [weak self] item in
            guard let item = item else { return }
            self?.titleLbl.text = item.title
            self?.descriptionLbl.text = item.description
            self?.priceLbl.text = "€\(item.price)"
            self?.productImageView.sd_setImage(with: URL(string: item.path))
        }.store(in: &subscriptions)
        
        // check favorite
        viewModel.$isItemInFavorite.sink { [weak self] state in
            if state {
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
            } else {
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
            }
            
            //print(self?.viewModel.favorites)
        }.store(in: &subscriptions)
        
        viewModel.$isItemInBasket.sink { [weak self] state in
            
            if state {
                self?.buyBtn.tintColor = .black
                self?.buyBtn.backgroundColor = .cakeWhite
                self?.buyBtn.setTitle("Go to basket", for: .normal)
                self?.buyBtn.addTarget(self, action: #selector(self?.didTapGoToBasket), for: .touchUpInside)
            } else {
                self?.buyBtn.tintColor = .cakeWhite
                self?.buyBtn.backgroundColor = .black
                self?.buyBtn.setTitle("Buy", for: .normal)
                self?.buyBtn.addTarget(self, action: #selector(self?.didTapBuy), for: .touchUpInside)
            }
            
        }.store(in: &subscriptions)
        
        // value
        viewModel.$valueToOrder.sink { [weak self] value in
            self?.valueLbl.text = "\(value)"
        }.store(in: &subscriptions)
        
        // minus btn
        viewModel.$isMinusValueActive.sink { [weak self] state in
            self?.minusValueBtn.isEnabled = state
            
            if state {
                self?.minusValueBtn.backgroundColor = .black
            } else {
                self?.minusValueBtn.backgroundColor = .black.withAlphaComponent(0.7)
            }
            
        }.store(in: &subscriptions)
        
        // plus btn
        viewModel.$isPlusValueActive.sink { [weak self] state in
            self?.plusValueBtn.isEnabled = state
            
            if state {
                self?.plusValueBtn.backgroundColor = .black
            } else {
                self?.plusValueBtn.backgroundColor = .black.withAlphaComponent(0.7)
            }
            
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(topSeparatorView)
        view.addSubview(scrollView)
        scrollView.addSubview(imageContainerView)
        imageContainerView.addSubview(productImageView)
        scrollView.addSubview(titleLbl)
        scrollView.addSubview(priceLbl)
        scrollView.addSubview(minusValueBtn)
        scrollView.addSubview(valueLbl)
        scrollView.addSubview(plusValueBtn)
        scrollView.addSubview(buyBtn)
        scrollView.addSubview(descriptionLbl)
        scrollView.addSubview(callUsView)
        
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
        
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 20)
        ]
        
        let priceLblConstraints = [
            priceLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor, constant: 5),
            priceLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20)
        ]
        
        let minusValueBtnConstraints = [
            minusValueBtn.heightAnchor.constraint(equalToConstant: 40),
            minusValueBtn.widthAnchor.constraint(equalToConstant: 40),
            minusValueBtn.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            minusValueBtn.topAnchor.constraint(equalTo: priceLbl.bottomAnchor, constant: 30)
        ]
        
        let valueLblConstraints = [
            valueLbl.centerYAnchor.constraint(equalTo: minusValueBtn.centerYAnchor),
            valueLbl.leadingAnchor.constraint(equalTo: minusValueBtn.trailingAnchor, constant: 15)
        ]
        
        let plusValueBtnConstraints = [
            plusValueBtn.heightAnchor.constraint(equalToConstant: 40),
            plusValueBtn.widthAnchor.constraint(equalToConstant: 40),
            plusValueBtn.leadingAnchor.constraint(equalTo: valueLbl.trailingAnchor, constant: 15),
            plusValueBtn.topAnchor.constraint(equalTo: minusValueBtn.topAnchor)
        ]
        
        let buyBtnConstraints = [
            buyBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buyBtn.centerYAnchor.constraint(equalTo: plusValueBtn.centerYAnchor),
            //buyBtn.leadingAnchor.constraint(equalTo: plusValueBtn.trailingAnchor, constant: 30),
            buyBtn.heightAnchor.constraint(equalToConstant: 50),
            buyBtn.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        let descriptionLblConstraints = [
            descriptionLbl.topAnchor.constraint(equalTo: buyBtn.bottomAnchor, constant: 30),
            descriptionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ]
        
        let callUsViewConstraints = [
            callUsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            callUsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            callUsView.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor, constant: 30),
            callUsView.heightAnchor.constraint(equalToConstant: 100),
            callUsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(imageContainerViewConstraints)
        NSLayoutConstraint.activate(productImageViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
        NSLayoutConstraint.activate(minusValueBtnConstraints)
        NSLayoutConstraint.activate(valueLblConstraints)
        NSLayoutConstraint.activate(plusValueBtnConstraints)
        NSLayoutConstraint.activate(buyBtnConstraints)
        NSLayoutConstraint.activate(descriptionLblConstraints)
        NSLayoutConstraint.activate(callUsViewConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: #selector(didPressAddToFavorite))
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
