//
//  OfferTableFooterView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 23/07/2023.
//

import UIKit

protocol OfferTableFooterViewDelegate: AnyObject {
    func didTapOrder()
}

class OfferTableFooterView: UIView {
    
    //MARK: - Delegate
    weak var delegate: OfferTableFooterViewDelegate?
    
    //MARK: - UI Objects
    private let checkoutBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Checkout", for: .normal)
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
        
        //btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let discountValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€0.00"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let discountLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your discount"
        lbl.font = UIFont(name: "Futura", size: 18)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€22.00"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let descriptionOfItemsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "items for the sum of"
        lbl.font = UIFont(name: "Futura", size: 18)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let amountToOrderLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "5"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // bg color
        backgroundColor = .clear
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(topSeparatorView)
        addSubview(amountToOrderLbl)
        addSubview(descriptionOfItemsLbl)
        addSubview(priceLbl)
        addSubview(discountLbl)
        addSubview(discountValueLbl)
        addSubview(checkoutBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let topSeparatorViewConstraints = [
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            topSeparatorView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let amountToOrderLblConstraints = [
            amountToOrderLbl.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 20),
            amountToOrderLbl.leadingAnchor.constraint(equalTo: topSeparatorView.leadingAnchor)
        ]
        
        let descriptionOfItemsLblConstraints = [
            descriptionOfItemsLbl.leadingAnchor.constraint(equalTo: amountToOrderLbl.trailingAnchor, constant: 10),
            descriptionOfItemsLbl.centerYAnchor.constraint(equalTo: amountToOrderLbl.centerYAnchor)
        ]
        
        let priceLblConstraints = [
            priceLbl.trailingAnchor.constraint(equalTo: topSeparatorView.trailingAnchor),
            priceLbl.centerYAnchor.constraint(equalTo: descriptionOfItemsLbl.centerYAnchor)
        ]
        
        let discountLblConstraints = [
            discountLbl.topAnchor.constraint(equalTo: amountToOrderLbl.bottomAnchor, constant: 30),
            discountLbl.leadingAnchor.constraint(equalTo: topSeparatorView.leadingAnchor)
        ]
        
        let discountValueLblConstraints = [
            discountValueLbl.trailingAnchor.constraint(equalTo: topSeparatorView.trailingAnchor),
            discountValueLbl.centerYAnchor.constraint(equalTo: discountLbl.centerYAnchor)
        ]
        
        let checkoutBtnConstraints = [
            checkoutBtn.leadingAnchor.constraint(equalTo: topSeparatorView.leadingAnchor),
            checkoutBtn.trailingAnchor.constraint(equalTo: topSeparatorView.trailingAnchor),
            checkoutBtn.topAnchor.constraint(equalTo: discountValueLbl.bottomAnchor, constant: 30),
            checkoutBtn.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(amountToOrderLblConstraints)
        NSLayoutConstraint.activate(descriptionOfItemsLblConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
        NSLayoutConstraint.activate(discountLblConstraints)
        NSLayoutConstraint.activate(discountValueLblConstraints)
        NSLayoutConstraint.activate(checkoutBtnConstraints)
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
