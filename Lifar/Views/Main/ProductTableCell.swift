//
//  productTableCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 12/07/2023.
//

import UIKit

class ProductTableCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier = "ProductTableCell"

    //MARK: - UI Objects
    private let customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellWhite//.white.withAlphaComponent(0.5)
        //view.clipsToBounds = true
        view.layer.cornerRadius = 15
        // shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // bg color
        backgroundColor = .clear
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(customContentView)
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let customContentViewConstrants = [
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(customContentViewConstrants)
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
