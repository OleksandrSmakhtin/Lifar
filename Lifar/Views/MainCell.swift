//
//  MainCell.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27.05.2023.
//

import UIKit

class MainCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier = "MainCell"
    
    //MARK: - Data
    private let products = ["d", "d", "d", "d", "d", "d", "d", "d"]
    
    //MARK: - UI Objects
    private let productsCollectionView: UICollectionView = {
        // create a layout to define a scroll direction
        let layout = UICollectionViewFlowLayout()
        // set item size
        layout.itemSize = CGSize(width: 170, height: 200)
        layout.scrollDirection = .horizontal
        //layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        return collectionView
    }() 
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // bg color
        backgroundColor = .clear
        // add subviews
        contentView.addSubview(productsCollectionView)
        // apply delegates
        applyCollectionDelegates()
    }
    
    //MARK: - didLayotSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        productsCollectionView.frame = contentView.bounds
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
