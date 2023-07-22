//
//  productTableCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 12/07/2023.
//

import UIKit
import SDWebImage
import Combine

protocol BasketTableCellDelegate: AnyObject {
    func didTapDelete(title: String)
    func shouldUpdateRow()
}

class BasketTableCell: UITableViewCell {
    
    //MARK: - Model
    private var viewModel = BasketCellViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Delegate
    weak var delegate: BasketTableCellDelegate?
        
    //MARK: - Identifier
    static let identifier = "ProductTableCell"

    //MARK: - UI Objects
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "White flowers"
        lbl.numberOfLines = 2
        lbl.textColor = .black
        lbl.font = UIFont(name: "Futura", size: 21)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "€22.00"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
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
        btn.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let minusValueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 14
        btn.addTarget(self, action: #selector(didTapMinusBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let plusValueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 14
        btn.addTarget(self, action: #selector(didTapPlusBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let valueLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - Actions
    @objc private func didTapDelete() {
        guard let title = titleLbl.text else { return }
        //let indexPath = IndexPath(row: deleteItemBtn.tag, section: 0)
        delegate?.didTapDelete(title: title)
    }
    
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
    @objc private func didTapMinusBtn() {
        viewModel.minusValue()
        viewModel.validateValue()
        viewModel.calculatePrice(isPlusOperation: false)
        viewModel.updateItem()
        delegate?.shouldUpdateRow()
    }
    
    @objc private func didTapPlusBtn() {
        viewModel.plusValue()
        viewModel.validateValue()
        viewModel.calculatePrice(isPlusOperation: true)
        viewModel.updateItem()
        delegate?.shouldUpdateRow()
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // bg color
        backgroundColor = .clear
        // selection
        selectionStyle = .none
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // bind views
        bindViews()
        
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // model
        viewModel.$item.sink { [weak self] model in
            guard let model = model else { return }
            self?.titleLbl.text = model.title
            self?.valueLbl.text = "\(model.amountForOrder)"
            self?.priceLbl.text = "€\(model.price)"
            self?.itemImageView.sd_setImage(with: URL(string: model.path))
        }.store(in: &subscriptions)
        
        // minus btn
        viewModel.$isMinusValueActive.sink { [weak self] state in
            self?.minusValueBtn.isEnabled = state
            
            if state {
                self?.minusValueBtn.backgroundColor = .black
            } else {
                self?.minusValueBtn.backgroundColor = .black.withAlphaComponent(0.7)
            }
            
        }.store(in: &subscriptions)
        
        // plus btn
        viewModel.$isPlusValueActive.sink { [weak self] state in
            self?.plusValueBtn.isEnabled = state
            
            if state {
                self?.plusValueBtn.backgroundColor = .black
            } else {
                self?.plusValueBtn.backgroundColor = .black.withAlphaComponent(0.7)
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(customContentView)
        contentView.addSubview(deleteItemBtn)
        customContentView.addSubview(itemImageView)
        customContentView.addSubview(titleLbl)
        customContentView.addSubview(priceLbl)
        contentView.addSubview(minusValueBtn)
        customContentView.addSubview(valueLbl)
        contentView.addSubview(plusValueBtn)
        
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
            deleteItemBtn.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 20),
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
            titleLbl.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 25),
        ]
        
        let priceLblConstraints = [
            //priceLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            //priceLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10)
            priceLbl.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -30),
            priceLbl.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -20)
        ]
        
        let minusValueBtnConstraints = [
            minusValueBtn.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            minusValueBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20),
            minusValueBtn.heightAnchor.constraint(equalToConstant: 28),
            minusValueBtn.widthAnchor.constraint(equalToConstant: 28)
        ]
        
        let valueLblConstraints = [
            valueLbl.centerYAnchor.constraint(equalTo: minusValueBtn.centerYAnchor),
            valueLbl.leadingAnchor.constraint(equalTo: minusValueBtn.trailingAnchor, constant: 15)
        ]
        
        let plusValueBtnConstraints = [
            plusValueBtn.centerYAnchor.constraint(equalTo: minusValueBtn.centerYAnchor),
            plusValueBtn.leadingAnchor.constraint(equalTo: valueLbl.trailingAnchor, constant: 15),
            plusValueBtn.heightAnchor.constraint(equalToConstant: 28),
            plusValueBtn.widthAnchor.constraint(equalToConstant: 28)
        ]
        
        NSLayoutConstraint.activate(customContentViewConstrants)
        NSLayoutConstraint.activate(deleteItemBtnConstraints)
        NSLayoutConstraint.activate(itemImageViewConstraints)
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(priceLblConstraints)
        NSLayoutConstraint.activate(minusValueBtnConstraints)
        NSLayoutConstraint.activate(valueLblConstraints)
        NSLayoutConstraint.activate(plusValueBtnConstraints)
    }
    
    
    //MARK: - Configure
    public func configure(with model: Cake) {
        viewModel.item = model
        viewModel.validateValue()
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}
