//
//  productTableCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 12/07/2023.
//

import UIKit
import SDWebImage

class ProductTableCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier = "ProductTableCell"

    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "White flowers"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€22.00"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "testCake")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let deleteItemBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)), for: .normal)
        btn.tintColor = .black.withAlphaComponent(0.7)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
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
        contentView.addSubview(deleteItemBtn)
        customContentView.addSubview(itemImageView)
        customContentView.addSubview(titleLbl)
        customContentView.addSubview(priceLbl)
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let customContentViewConstrants = [
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let deleteItemBtnConstraints = [
            deleteItemBtn.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            deleteItemBtn.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -20)
        ]
        
        let itemImageViewConstraints = [
            itemImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
            itemImageView.topAnchor.constraint(equalTo: customContentView.topAnchor),
            itemImageView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 3),
            titleLbl.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 20),
        ]
        
        let priceLblConstraints = [
            priceLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            priceLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(customContentViewConstrants)
        NSLayoutConstraint.activate(deleteItemBtnConstraints)
        NSLayoutConstraint.activate(itemImageViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
    }
    
    
    //MARK: - Configure
    public func configure(with model: Cake) {
        titleLbl.text = model.title
        priceLbl.text = "€\(model.price)"
        itemImageView.sd_setImage(with: URL(string: model.path))
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
