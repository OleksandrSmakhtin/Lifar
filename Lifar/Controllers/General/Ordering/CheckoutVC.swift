//
//  OrderConfirmationVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 30/07/2023.
//

import UIKit
import Combine

class CheckoutVC: UIViewController {
    
    //MARK: - ViewModel
    private(set) var viewModel = CheckoutViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Name:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let nameValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "Alex"
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let contactMethodLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Contact method:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let emailMethodBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Email", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        btn.backgroundColor = .black
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 18
        
        btn.addTarget(self, action: #selector(didTapEmailMethodBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let phoneMethodBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setTitle("Phone", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 18
        
        btn.addTarget(self, action: #selector(didTapPhoneMethodBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let yourOrderLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your order:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let yourOrderValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "Cream Dream, Flower Dream, Sky Flowers, Tropic Dream, White Dream, Ice Cake"
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let addressLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Address:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let addressValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "Ballybane Rd, Glassan Student Village"
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let deliveryLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Delivery:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let pickupBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Pickup", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        btn.backgroundColor = .black
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 18
        
        btn.addTarget(self, action: #selector(didTapPickupBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let deliveryBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .black
        btn.setTitle("Delivery", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        btn.backgroundColor = .clear
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 18
        
        btn.addTarget(self, action: #selector(didTapDeliveryBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let toPayLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "To pay:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let toPayValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€344"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let confirmBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Confirm", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        btn.backgroundColor = .black
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 18
        // shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        
        btn.addTarget(self, action: #selector(didTapConfirmBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapConfirmBtn() {
        viewModel.createOrder()
        confirmBtn.isEnabled = false
    }
    
    @objc private func didTapEmailMethodBtn() {
        viewModel.changeContactMethod(changeTo: .byEmail)
    }
    
    @objc private func didTapPhoneMethodBtn() {
        viewModel.changeContactMethod(changeTo: .byPhone)
    }
    
    @objc private func didTapPickupBtn() {
        viewModel.changeDeliveryMethod(changeTo: DeliveryType.pickup)
    }
    
    @objc private func didTapDeliveryBtn() {
        viewModel.changeDeliveryMethod(changeTo: DeliveryType.delivery)
    }

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // bind views
        bindViews()
        
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retreiveUser()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        
        // is successed
        viewModel.$isOrderSuccessed.sink { [weak self] state in
            if state {
                self?.viewModel.deleteBasket()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                        self?.confirmBtn.isEnabled = true
                        self?.confirmBtn.backgroundColor = .systemGreen
                        self?.confirmBtn.setTitle("Successful!", for: .normal)
                        self?.confirmBtn.isUserInteractionEnabled = false
                        self?.confirmBtn.layer.borderColor = UIColor.systemGreen.cgColor
                        self?.confirmBtn.layer.opacity = 1
                    } completion: { _ in }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }.store(in: &subscriptions)
        
        // items
        viewModel.$itemsToOrder.sink { [weak self] items in
            guard let items = items else { return }
            
            self?.yourOrderValueLbl.text = self?.viewModel.getFormattedItems(items: items)
        }.store(in: &subscriptions)
        
        // user
        viewModel.$user.sink { [weak self] user in
            guard let user = user else { return }
            
            self?.nameValueLbl.text = user.name
            self?.addressValueLbl.text = "\(user.address1) \(user.address2)"
        }.store(in: &subscriptions)
        
        // contact method
        viewModel.$contactMethod.sink { [weak self] type in
            if type == .byPhone {
                self?.emailMethodBtn.backgroundColor = .clear
                self?.emailMethodBtn.tintColor = .black
                
                self?.phoneMethodBtn.backgroundColor = .black
                self?.phoneMethodBtn.tintColor = .cakeWhite
            } else {
                self?.emailMethodBtn.backgroundColor = .black
                self?.emailMethodBtn.tintColor = .cakeWhite
                
                self?.phoneMethodBtn.backgroundColor = .clear
                self?.phoneMethodBtn.tintColor = .black
            }
        }.store(in: &subscriptions)
        
        // delivery method
        viewModel.$delivery.sink { [weak self] type in
            
            if type == .delivery {
                self?.pickupBtn.backgroundColor = .clear
                self?.pickupBtn.tintColor = .black
                
                self?.deliveryBtn.backgroundColor = .black
                self?.deliveryBtn.tintColor = .cakeWhite
            } else {
                self?.pickupBtn.backgroundColor = .black
                self?.pickupBtn.tintColor = .cakeWhite
                
                self?.deliveryBtn.backgroundColor = .clear
                self?.deliveryBtn.tintColor = .black
            }
            
        }.store(in: &subscriptions)
        
        // price
        viewModel.$orderPrice.sink { [weak self] price in
            guard let price = price else { return }
            self?.toPayValueLbl.text = "€\(price)0"
        }.store(in: &subscriptions)
    }

    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(nameLbl)
        view.addSubview(nameValueLbl)
        view.addSubview(contactMethodLbl)
        view.addSubview(emailMethodBtn)
        view.addSubview(phoneMethodBtn)
        view.addSubview(yourOrderLbl)
        view.addSubview(yourOrderValueLbl)
        view.addSubview(addressLbl)
        view.addSubview(addressValueLbl)
        view.addSubview(deliveryLbl)
        view.addSubview(pickupBtn)
        view.addSubview(deliveryBtn)
        view.addSubview(toPayLbl)
        view.addSubview(toPayValueLbl)
        view.addSubview(confirmBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let nameLblConstraints = [
            nameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ]
        
        let nameValueLblConstraints = [
            nameValueLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameValueLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor, constant: 10),
            nameValueLbl.centerYAnchor.constraint(equalTo: nameLbl.centerYAnchor),
        ]
        
        let contactMethodLblConstraints = [
            contactMethodLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),
            contactMethodLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 30)
        ]
        //
        let emailMethodBtnConstraints = [
            emailMethodBtn.leadingAnchor.constraint(equalTo: contactMethodLbl.trailingAnchor, constant: 10),
            emailMethodBtn.centerYAnchor.constraint(equalTo: contactMethodLbl.centerYAnchor),
            emailMethodBtn.heightAnchor.constraint(equalToConstant: 35),
            emailMethodBtn.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        let phoneMethodBtnConstraints = [
            phoneMethodBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneMethodBtn.centerYAnchor.constraint(equalTo: contactMethodLbl.centerYAnchor),
            phoneMethodBtn.leadingAnchor.constraint(equalTo: emailMethodBtn.trailingAnchor, constant: 10),
            phoneMethodBtn.heightAnchor.constraint(equalToConstant: 35),
            phoneMethodBtn.widthAnchor.constraint(equalToConstant: 80)
        ]
         
        let yourOrderLblConstraints = [
            yourOrderLbl.leadingAnchor.constraint(equalTo: contactMethodLbl.leadingAnchor),
            yourOrderLbl.topAnchor.constraint(equalTo: contactMethodLbl.bottomAnchor, constant: 30)
        ]

        let yourOrderValueLblConstraints = [
            yourOrderValueLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            yourOrderValueLbl.topAnchor.constraint(equalTo: contactMethodLbl.bottomAnchor, constant: 32),
            yourOrderValueLbl.leadingAnchor.constraint(equalTo: yourOrderLbl.trailingAnchor, constant: 10)
        ]

        let addressLblConstraints = [
            addressLbl.leadingAnchor.constraint(equalTo: yourOrderLbl.leadingAnchor),
            addressLbl.topAnchor.constraint(equalTo: yourOrderValueLbl.bottomAnchor, constant: 30)
        ]

        let addressValueLblConstraints = [
            addressValueLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addressValueLbl.topAnchor.constraint(equalTo: yourOrderValueLbl.bottomAnchor, constant: 32),
            addressValueLbl.leadingAnchor.constraint(equalTo: addressLbl.trailingAnchor, constant: 10)
        ]

        let deliveryLblConstraints = [
            deliveryLbl.leadingAnchor.constraint(equalTo: addressLbl.leadingAnchor),
            deliveryLbl.topAnchor.constraint(equalTo: addressValueLbl.bottomAnchor, constant: 30)
        ]

        let pickupBtnConstraints = [
            pickupBtn.leadingAnchor.constraint(equalTo: deliveryLbl.trailingAnchor, constant: 10),
            pickupBtn.centerYAnchor.constraint(equalTo: deliveryLbl.centerYAnchor),
            pickupBtn.heightAnchor.constraint(equalToConstant: 35),
            pickupBtn.widthAnchor.constraint(equalToConstant: 100)
        ]

        let deliveryBtnConstraints = [
            deliveryBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deliveryBtn.centerYAnchor.constraint(equalTo: deliveryLbl.centerYAnchor),
            deliveryBtn.leadingAnchor.constraint(equalTo: pickupBtn.trailingAnchor, constant: 20),
            deliveryBtn.heightAnchor.constraint(equalToConstant: 35),
            deliveryBtn.widthAnchor.constraint(equalToConstant: 100)
        ]

        let toPayLblConstraints = [
            toPayLbl.leadingAnchor.constraint(equalTo: deliveryLbl.leadingAnchor),
            toPayLbl.topAnchor.constraint(equalTo: deliveryLbl.bottomAnchor, constant: 30)
        ]

        let toPayValueLblConstraints = [
            toPayValueLbl.centerYAnchor.constraint(equalTo: toPayLbl.centerYAnchor),
            toPayValueLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]

        let confirmBtnConstraints = [
            confirmBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmBtn.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        NSLayoutConstraint.activate(nameLblConstraints)
        NSLayoutConstraint.activate(nameValueLblConstraints)
        NSLayoutConstraint.activate(contactMethodLblConstraints)
        NSLayoutConstraint.activate(emailMethodBtnConstraints)
        NSLayoutConstraint.activate(phoneMethodBtnConstraints)
        NSLayoutConstraint.activate(yourOrderLblConstraints)
        NSLayoutConstraint.activate(yourOrderValueLblConstraints)
        NSLayoutConstraint.activate(addressLblConstraints)
        NSLayoutConstraint.activate(addressValueLblConstraints)
        NSLayoutConstraint.activate(deliveryLblConstraints)
        NSLayoutConstraint.activate(pickupBtnConstraints)
        NSLayoutConstraint.activate(deliveryBtnConstraints)
        NSLayoutConstraint.activate(toPayLblConstraints)
        NSLayoutConstraint.activate(toPayValueLblConstraints)
        NSLayoutConstraint.activate(confirmBtnConstraints)
    }

    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Checkout"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        navigationController?.navigationBar.backgroundColor = .cakeWhite
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }
    
}
