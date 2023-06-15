//
//  SideMenuCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 15.06.2023.
//

import UIKit

class SideMenuCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "SideMenuCell"
    
    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl  = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let menuImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(menuImage)
        contentView.addSubview(titleLbl)
    }
    
    //MARK: - apply constraints
    private func applyConstraints() {
        let menuImageConstraints = [
            menuImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            menuImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: menuImage.trailingAnchor, constant: 15),
            titleLbl.centerYAnchor.constraint(equalTo: menuImage.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(menuImageConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
    }
    
    //MARK: - Configure
    public func configure(with model: MenuItem) {
        titleLbl.text = model.title
        menuImage.image = UIImage(systemName: model.image)
    }
}
