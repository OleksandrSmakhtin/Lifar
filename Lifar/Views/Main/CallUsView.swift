//
//  MainTableFooter.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27.05.2023.
//

import UIKit

class CallUsView: UIView {

    //MARK: - UI Objects
    private let callUsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "CALL US"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let callUsBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .cakeWhite
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 20
        // shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        
        btn.addTarget(self, action: #selector(didTapCall), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapCall() {
        print("CALL BTN PRESSED")
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
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(callUsBtn)
        callUsBtn.addSubview(phoneImageView)
        callUsBtn.addSubview(callUsLbl)
    }

    //MARK: - Apply constraints
    private func applyConstraints() {
        let callUsBtnConstraints = [
            callUsBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            callUsBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            callUsBtn.heightAnchor.constraint(equalToConstant: 70),
            callUsBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ]
        
        let phoneImageViewConstraints = [
            phoneImageView.leadingAnchor.constraint(equalTo: callUsBtn.leadingAnchor, constant: 40),
            phoneImageView.centerYAnchor.constraint(equalTo: callUsBtn.centerYAnchor)
        ]
        
        let callUsLblConstraints = [
            callUsLbl.centerXAnchor.constraint(equalTo: callUsBtn.centerXAnchor),
            callUsLbl.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(callUsBtnConstraints)
        NSLayoutConstraint.activate(phoneImageViewConstraints)
        NSLayoutConstraint.activate(callUsLblConstraints)
    }
}
