//
//  EmptyView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 18/07/2023.
//

import UIKit

protocol EmptyViewDelegate: AnyObject {
    func didTapGoToPtoducts()
}

class EmptyView: UIView {
    
    //MARK: - Delegate
    weak var delegate: EmptyViewDelegate?

    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Looks like it's emty" 
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let goToProductsBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .cakeWhite
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 20
        
        btn.setTitle("GO TO PRODUCTS", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        btn.tintColor = .black
        
        // shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        
        btn.addTarget(self, action: #selector(didTapGoToProdBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapGoToProdBtn() {
        delegate?.didTapGoToPtoducts()
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // bg color
        backgroundColor = .clear
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // enable constraints
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(titleLbl)
        addSubview(goToProductsBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let titleLblConstraints = [
            titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150)
        ]
        
        let goToProductsBtnConstraints = [
            goToProductsBtn.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            goToProductsBtn.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor),
            goToProductsBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 30),
            goToProductsBtn.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(goToProductsBtnConstraints)
    }
    
    
    
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
