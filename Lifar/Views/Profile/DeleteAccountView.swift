//
//  DeleteAccountView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27/06/2023.
//

import UIKit

protocol DeleteAccountViewDelegate: AnyObject {
    func didTapDeleteAccountBtn()
}

class DeleteAccountView: UIView {
    
    //MARK: - Delegate
    weak var delegate: DeleteAccountViewDelegate?

    //MARK: - UI Objects
    private let deleteBtn: UIButton = {
        let btn = UIButton(type: .system)
        // border
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.systemRed.cgColor
        btn.layer.cornerRadius = 10
        // shadow
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        // title
        btn.tintColor = .systemRed
        btn.setTitle("Delete account", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Futura", size: 17)
        
        btn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //MARK: - Actions
    @objc private func didTapDeleteBtn() {
        delegate?.didTapDeleteAccountBtn()
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(deleteBtn)
        
        NSLayoutConstraint.activate([
            deleteBtn.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            deleteBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            deleteBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteBtn.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
