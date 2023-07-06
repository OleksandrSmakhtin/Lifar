//
//  MainCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27.05.2023.
//

import UIKit

protocol MainCellDelegate: AnyObject {
    func didSelectItem(item: Cake)
}

class MainCell: UITableViewCell {
    
    //MARK: - Delegate
    weak var delegate: MainCellDelegate?
    
    //MARK: - Identifier
    static let identifier = "MainCell"
    
    //MARK: - Data
    private var cakes: [Cake] = []
    private var isCustom = false
    private var categoryForCustom: CategoriesTabs? = nil
    
    //MARK: - UI Objects
    private let productsCollectionView: UICollectionView = {
        // create a layout to define a scroll direction
        let layout = UICollectionViewFlowLayout()
        // set item size
        layout.itemSize = CGSize(width: 170, height: 230)
        layout.scrollDirection = .horizontal
        //layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }() 
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // bg color
        backgroundColor = .clear
        // add subviews
        contentView.addSubview(productsCollectionView)
        // apply constraints
        applyConstraints()
        // apply delegates
        applyCollectionDelegates()
    }
    
    //MARK: - didLayotSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        //productsCollectionView.frame = contentView.bounds
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let productsCollectionViewConstraints = [
            productsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(productsCollectionViewConstraints)
    }
    
    //MARK: - Configure
    public func configure(with cakes: [Cake]) {
        self.cakes = cakes
        
        DispatchQueue.main.async { [weak self] in
            self?.productsCollectionView.reloadData()
        }
    }
    
    //MARK: - required init
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - UICollectionViewDelegate & DataSource
extension MainCell: UICollectionViewDelegate, UICollectionViewDataSource {
    private func applyCollectionDelegates() {
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    // number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cakes.count
    }
    
    // cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { return UICollectionViewCell() }

        cell.configure(cake: cakes[indexPath.row])
        
        return cell
    }
    
    // did select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = cakes[indexPath.row]
        
        delegate?.didSelectItem(item: item)
        
    }
    
    
}
