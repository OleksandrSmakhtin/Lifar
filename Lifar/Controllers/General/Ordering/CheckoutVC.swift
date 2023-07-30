//
//  OrderConfirmationVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 30/07/2023.
//

import UIKit

class CheckoutVC: UIViewController {
    
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
    
    private let emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Email:"
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let emailValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "skiper.smaxtin@icloud.com"
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
        // shadow
//        btn.layer.shadowColor = UIColor.black.cgColor
//        btn.layer.shadowOpacity = 0.5
//        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
//        btn.layer.shadowRadius = 4
        
        //btn.addTarget(self, action: #selector(didTapChechoutBtn), for: .touchUpInside)
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
        // shadow
//        btn.layer.shadowColor = UIColor.black.cgColor
//        btn.layer.shadowOpacity = 0.5
//        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
//        btn.layer.shadowRadius = 4
        
        //btn.addTarget(self, action: #selector(didTapChechoutBtn), for: .touchUpInside)
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
        
        //btn.addTarget(self, action: #selector(didTapChechoutBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
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
        
    }

    //MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(nameLbl)
        view.addSubview(nameValueLbl)
        view.addSubview(emailLbl)
        view.addSubview(emailValueLbl)
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
        
        let emailLblConstraints = [
            emailLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),
            emailLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 30)
        ]
        
        let emailValueLblConstraints = [
            emailValueLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailValueLbl.leadingAnchor.constraint(equalTo: emailLbl.trailingAnchor, constant: 10),
            emailValueLbl.centerYAnchor.constraint(equalTo: emailLbl.centerYAnchor),
        ]
        
        let yourOrderLblConstraints = [
            yourOrderLbl.leadingAnchor.constraint(equalTo: emailLbl.leadingAnchor),
            yourOrderLbl.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 30)
        ]
        
        let yourOrderValueLblConstraints = [
            yourOrderValueLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            yourOrderValueLbl.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 32),
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
        NSLayoutConstraint.activate(emailLblConstraints)
        NSLayoutConstraint.activate(emailValueLblConstraints)
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
