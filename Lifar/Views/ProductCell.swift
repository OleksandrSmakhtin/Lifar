//
//  ProductCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27.05.2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier = "ProductCell"
    
    //MARK: - UI Objects
    private let customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .cakeWhite
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // bg color
        contentView.backgroundColor = .clear
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
        contentView.addSubview(customContentView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let customContentViewConstraints = [
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(customContentViewConstraints)
    }
}
