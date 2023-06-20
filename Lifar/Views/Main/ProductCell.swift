//
//  ProductCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27.05.2023.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static let identifier = "ProductCell"
    
    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 15)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€22.00"
        lbl.font = UIFont(name: "Futura", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let addToFavoriteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(didTapAddToFavorite), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testCake")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    //MARK: - Actions
    @objc private func didTapAddToFavorite() {
        print("\(titleLbl.text) WAS ADDED TO FAV")
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // bg color
        contentView.backgroundColor = .clear
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: 4, height: 4) // Положительные значения
//        layer.shadowRadius = 4
        
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(customContentView)
        customContentView.addSubview(productImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(priceLbl)
        contentView.addSubview(addToFavoriteBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let customContentViewConstraints = [
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let productImageViewConstraints = [
            productImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 5),
            productImageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -5),
            productImageView.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 5),
            productImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2 + 20)
        ]
        
        let titleLblConstraints = [
            titleLbl.centerXAnchor.constraint(equalTo: customContentView.centerXAnchor),
            titleLbl.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5)
        ]
        
        let priceLblConstraints = [
            priceLbl.centerXAnchor.constraint(equalTo: titleLbl.centerXAnchor),
            priceLbl.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -10)
        ]
        
        let addToFavoriteBtnConstraints = [
            addToFavoriteBtn.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 10),
            addToFavoriteBtn.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(customContentViewConstraints)
        NSLayoutConstraint.activate(productImageViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
        NSLayoutConstraint.activate(addToFavoriteBtnConstraints)
    }
    
    //MARK: - Configure
    public func configure(cake: Cake) {
        
        
        switch cake.title {
        case CategoriesTabs.wedding.rawValue:
            priceLbl.text = "€100"
            configureCustom()
        case CategoriesTabs.celebration.rawValue:
            priceLbl.text = "€80"
            configureCustom()
        case CategoriesTabs.tarts.rawValue:
            priceLbl.text = "€60"
            configureCustom()
        case CategoriesTabs.cupcakes.rawValue:
            priceLbl.text = "€70"
            configureCustom()
        case CategoriesTabs.miniCupcakes.rawValue:
            priceLbl.text = "€60"
            configureCustom()
        case CategoriesTabs.desserts.rawValue:
            priceLbl.text = "€50"
            configureCustom()
        case CategoriesTabs.macarons.rawValue:
            priceLbl.text = "€30"
            configureCustom()
        default:
            titleLbl.text = cake.title
            productImageView.sd_setImage(with: URL(string: cake.path))
            priceLbl.text = "€\(cake.price)"
        }
        
        
        
//        titleLbl.text = cake.title
//        productImageView.sd_setImage(with: URL(string: cake.path))
//        priceLbl.text = "€\(cake.price)"
    }
    
    //MARK: - Configure custom
    private func configureCustom() {
        titleLbl.text = "Create your custom"
        productImageView.image = UIImage(named: "custom")
    }
    
}
