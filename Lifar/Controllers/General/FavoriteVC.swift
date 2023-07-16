//
//  FavoriteVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit
import Combine

class FavoriteVC: UIViewController {
    
    
    //MARK: - ViewModel
    private var viewModel = FavoriteViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Object
    private let favoritesTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: ProductTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .cakeWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyTableDelegates()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoriteItems()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        
        // bind items
        viewModel.$favItems.sink { [weak self] items in
            DispatchQueue.main.async {
                self?.favoritesTable.reloadData()
            }
        }.store(in: &subscriptions)
        
        
        
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(topSeparatorView)
        view.addSubview(favoritesTable)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let topSeparatorViewConstraints = [
            topSeparatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let favoritesTableConstraints = [
            favoritesTable.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            favoritesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(favoritesTableConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Favorite"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
        
        let clearAllLbl: UIButton = {
            let btn = UIButton(type: .system)
            btn.tintColor = .systemRed
            btn.setTitle("Clear All", for: .normal)
            btn.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearAllLbl)
    }
}


//MARK: - UITableViewDelegate & DataSource
extension FavoriteVC: UITableViewDelegate, UITableViewDataSource, ProductTableCellDelegate {
    
    // delegates
    private func applyTableDelegates() {
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favItems.count
    }
    
    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.identifier) as? ProductTableCell else { return UITableViewCell() }
        
        let model = viewModel.favItems[indexPath.row]
        cell.delegate = self
        cell.configure(with: model)
        
        
        return cell
    }
    
    // height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
    // did tap delete btn
    func didTapDelete(title: String) {
        print("ITEM TO DELETE: \(title)")
        viewModel.deleteItem(with: title)

    }
    
}
