//
//  SideMenuView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 15.06.2023.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func didSelectProfile()
    func didSelectOrders()
    func didSelectFavorite()
    func didSelectRate()
    func didSelectShare()
    func didSelectAbout()
}

class SideMenuView: UIView {
    
    //MARK: - Delegate
    weak var delegate: SideMenuDelegate?
    
    //MARK: - Data
    private let menuItems = MenuItemData.shared.getMenuItems()

    //MARK: -  UI Objects
    private let menuTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        //table.separatorStyle = .none
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.register(SideMenuCell.self, forCellReuseIdentifier: SideMenuCell.identifier)
        //table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        // bg color
        backgroundColor = .cakeWhite
        // add subviews
        addSubviews()
        // apply delegates
        applyTableDelegates()
        // isHidden
        //isHidden = true
        layer.opacity = 0
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 7, height: 10)
        layer.shadowRadius = 3
        layer.masksToBounds = false
        // enable constraints
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - reuired init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        menuTable.frame = bounds
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        addSubview(menuTable)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
    }
}

//MARK: - UITableViewDelegate & DataSource
extension SideMenuView: UITableViewDelegate, UITableViewDataSource {
    private func applyTableDelegates() {
        menuTable.delegate = self
        menuTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier) as? SideMenuCell else { return UITableViewCell() }
        cell.configure(with: menuItems[indexPath.row])
        return cell
    }
    
    // height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            delegate?.didSelectProfile()
        case 1:
            delegate?.didSelectOrders()
        case 2:
            delegate?.didSelectFavorite()
        case 3:
            delegate?.didSelectRate()
        case 4:
            delegate?.didSelectShare()
        case 5:
            delegate?.didSelectAbout()
        default:
            return
        }
    }
    
    
}
