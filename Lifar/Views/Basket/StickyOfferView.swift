//
//  StickyOfferView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 25/07/2023.
//

import UIKit

protocol StickyOfferViewDelegate: AnyObject {
    func didTapOrderBtn()
}

class StickyOfferView: UIView {
    
    //MARK: - Delegate
    weak var delegate: StickyOfferViewDelegate?

    //MARK: - UI Objects
    //MARK: - UI Objects
    private let checkoutBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .cakeWhite
        btn.setTitle("Checkout", for: .normal)
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
        
        //btn.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€22.00"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // bg colol
        backgroundColor = .cakeWhite
        // enable constraints
        translatesAutoresizingMaskIntoConstraints = false
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(separatorView)
        addSubview(priceLbl)
        addSubview(checkoutBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        // sepearato view constraints
        let separatorViewConstraints = [
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        // offer Btn constraints
        let checkoutBtnConstraints = [
            checkoutBtn.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            checkoutBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            checkoutBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            checkoutBtn.widthAnchor.constraint(equalToConstant: 220)
        ]
        
        // price Lbl constraints
        let priceLblConstraints = [
            priceLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            priceLbl.centerYAnchor.constraint(equalTo: checkoutBtn.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(separatorViewConstraints)
        NSLayoutConstraint.activate(checkoutBtnConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
    }

    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
