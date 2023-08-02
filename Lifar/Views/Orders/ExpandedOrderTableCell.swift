//
//  ExpandedOrderTableCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 02/08/2023.
//

import UIKit

class ExpandedOrderTableCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "ExpandedOrderTableCell"

    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Order from 02.08.23, 15:08"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let statusLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Status:"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let statusValueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "In Process"
        lbl.textColor = .systemOrange
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Price:"
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let contactMethodLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let detailsLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.7808385491, green: 0.7481611371, blue: 0.5794531703, alpha: 1)
        lbl.text = "Hide details"
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let detailsArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.tintColor = #colorLiteral(red: 0.7808385491, green: 0.7481611371, blue: 0.5794531703, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    private let customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .cellWhite//.white.withAlphaComponent(0.5)
        //view.clipsToBounds = true
        view.layer.cornerRadius = 15
        // shadow
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowOffset = CGSize(width: 4, height: 4)
//        view.layer.shadowRadius = 4
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // selction
        selectionStyle = .none
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
        customContentView.addSubview(detailsLbl)
        customContentView.addSubview(detailsArrowView)
        customContentView.addSubview(titleLbl)
        customContentView.addSubview(statusLbl)
        customContentView.addSubview(statusValueLbl)
        customContentView.addSubview(priceLbl)
        customContentView.addSubview(contactMethodLbl)
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let customContentViewConstrants = [
            //contentView.heightAnchor.constraint(equalToConstant: 100),
            customContentView.heightAnchor.constraint(equalToConstant: 400),
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let detailsLblConstraints = [
            detailsLbl.centerXAnchor.constraint(equalTo: customContentView.centerXAnchor),
            detailsLbl.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -5)
        ]
        
        let detailsArrowViewConstraints = [
            detailsArrowView.centerXAnchor.constraint(equalTo: detailsLbl.centerXAnchor),
            detailsArrowView.heightAnchor.constraint(equalToConstant: 10),
            detailsArrowView.widthAnchor.constraint(equalToConstant: 10),
            detailsArrowView.bottomAnchor.constraint(equalTo: detailsLbl.topAnchor, constant: -2)
        ]
        
        
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 20),
            titleLbl.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 15)
        ]
        
        let statusLblConstraints = [
            statusLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            statusLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10)
        ]
        
        let statusValueLblConstraints = [
            statusValueLbl.leadingAnchor.constraint(equalTo: statusLbl.trailingAnchor, constant: 5),
            statusValueLbl.centerYAnchor.constraint(equalTo: statusLbl.centerYAnchor)
        ]
        
        let priceLblConstraints = [
            priceLbl.leadingAnchor.constraint(equalTo: statusLbl.leadingAnchor),
            priceLbl.topAnchor.constraint(equalTo: statusLbl.bottomAnchor, constant: 10)
        ]
        
        let contactMethodLblConstraints = [
            contactMethodLbl.leadingAnchor.constraint(equalTo: priceLbl.leadingAnchor),
            contactMethodLbl.topAnchor.constraint(equalTo: priceLbl.bottomAnchor, constant: 10)
        ]
    
        NSLayoutConstraint.activate(customContentViewConstrants)
        NSLayoutConstraint.activate(detailsLblConstraints)
        NSLayoutConstraint.activate(detailsArrowViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(statusLblConstraints)
        NSLayoutConstraint.activate(statusValueLblConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
        NSLayoutConstraint.activate(contactMethodLblConstraints)
    }
        
    
    //MARK: - Configure
    public func configure(with model: Order) {
        titleLbl.text = "Order \(model.orderTime)"
        statusValueLbl.text = model.orderStatus
        priceLbl.text = "Price: €\(model.orderPrice)0"
        contactMethodLbl.text = "Contact method: \(model.contactMethod)"
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }

}
