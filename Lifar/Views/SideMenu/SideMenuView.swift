//
//  SideMenuView.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 15.06.2023.
//

import UIKit

class SideMenuView: UIView {
    
    //MARK: - Data
    private let menuItems = MenuItemData.shared.getMenuItems()

    //MARK: -  UI Objects
    private let menuTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        //table.separatorStyle = .none
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier) as? SideMenuCell else { return UITableViewCell() }
        
        cell.configure(with: menuItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
