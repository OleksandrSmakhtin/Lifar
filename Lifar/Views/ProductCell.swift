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
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 13)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
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
        contentView.addSubview(titleLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let customContentViewConstraints = [
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 5),
            titleLbl.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -5),
            titleLbl.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -5),
        ]
        
        NSLayoutConstraint.activate(customContentViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
    }
    
    //MARK: - Configure
    public func configure(cake: Cake) {
        titleLbl.text = cake.title
    }
    
}
