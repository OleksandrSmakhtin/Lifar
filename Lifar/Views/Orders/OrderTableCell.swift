//
//  OrderTableCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 02/08/2023.
//

import UIKit

class OrderTableCell: UITableViewCell {
    
    var isExpanded = false
        
    //MARK: - Identifier
    static let identifier = "OrderTableCell"

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
    
    private let detailsLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.7808385491, green: 0.7481611371, blue: 0.5794531703, alpha: 1)
        lbl.text = "Show details"
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let detailsArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
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
        customContentView.addSubview(detailsArrowView)
        customContentView.addSubview(detailsLbl)
        customContentView.addSubview(titleLbl)
        customContentView.addSubview(statusLbl)
        customContentView.addSubview(statusValueLbl)
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let customContentViewConstrants = [
            //contentView.heightAnchor.constraint(equalToConstant: 100),
            customContentView.heightAnchor.constraint(equalToConstant: 110),
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let detailsArrowViewConstraints = [
            detailsArrowView.centerXAnchor.constraint(equalTo: customContentView.centerXAnchor),
            detailsArrowView.heightAnchor.constraint(equalToConstant: 10),
            detailsArrowView.widthAnchor.constraint(equalToConstant: 10),
            detailsArrowView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -5)
        ]
        
        let detailsLblConstraints = [
            detailsLbl.centerXAnchor.constraint(equalTo: detailsArrowView.centerXAnchor),
            detailsLbl.bottomAnchor.constraint(equalTo: detailsArrowView.topAnchor, constant: -2)
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
    
        NSLayoutConstraint.activate(customContentViewConstrants)
        NSLayoutConstraint.activate(detailsArrowViewConstraints)
        NSLayoutConstraint.activate(detailsLblConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(statusLblConstraints)
        NSLayoutConstraint.activate(statusValueLblConstraints)
    }
        
    
    //MARK: - Configure
    public func configure(with model: Cake) {
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }


}
