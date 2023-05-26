//
//  CategoryView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 26.05.2023.
//

import UIKit

protocol CategoryViewDelegate: AnyObject {
    func didTapTab(with title: String)
}

class CategoryView: UIView {
    
    //MARK: - Delegate
    weak var delegate: CategoryViewDelegate?
    
    //MARK: - UI Objects
    private lazy var tabTapGesture: UITapGestureRecognizer = {
        let gest = UITapGestureRecognizer()
        gest.numberOfTapsRequired = 1
        gest.addTarget(self, action: #selector(didSelectTab))
        return gest
    }()
    
    var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Futura", size: 16)
        lbl.textColor = .cakePink
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // settings
        backgroundColor = .cakeWhite
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        addGestureRecognizer(tabTapGesture)
        //tabTapGesture.addTarget(self, action: #selector(didSelectTab))
        
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didSelectTab() {
        guard let title = titleLbl.text else { return }
        delegate?.didTapTab(with: title)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(titleLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let titleLblConstraints = [
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLbl.topAnchor.constraint(equalTo: topAnchor),
            titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(titleLblConstraints)
    }
    
    //MARK: - setTitle
    public func setTitle(title: String) {
        titleLbl.text = title
    }
    
    //MARK: - selectTab
    public func selectTab() {
        titleLbl.textColor = .cakeFuchsia
        layer.borderWidth = 2
        layer.borderColor = UIColor.cakeFuchsia?.cgColor
    }
    
    //MARK: - deselectTab
    public func deselectTab() {
        titleLbl.textColor = .cakePink
        layer.borderWidth = 0
    }
}
