//
//  CustomTextField.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit

class CustomTextField: UITextField {

    //MARK: - UI Objects
    private let targetLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Futura", size: 22)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    //MARK: - init
    init(frame: CGRect, target: String) {
        super.init(frame: frame)
        // set target lbl
        targetLbl.text = target
        // bg color
        backgroundColor = .cakeWhite
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // text
        textColor = .black
        tintColor = .black
        font = UIFont(name: "Futura", size: 20)
        keyboardType = .emailAddress
        autocorrectionType = .no
        // borders & corners
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 20
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 4
        // padding from beggining
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        // enable constraints
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(targetLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let targetLblConstraints = [
            targetLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            targetLbl.bottomAnchor.constraint(equalTo: topAnchor, constant: -7)
        ]
        
        NSLayoutConstraint.activate(targetLblConstraints)
    }
    
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
