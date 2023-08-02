//
//  OrdersVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27/06/2023.
//

import UIKit
import Combine

class OrdersVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = OrdersViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let ordersTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderTableCell.self, forCellReuseIdentifier: OrderTableCell.identifier)
        tableView.register(ExpandedOrderTableCell.self, forCellReuseIdentifier: ExpandedOrderTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .cakeWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyView = EmptyView()

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
        viewModel.retreiveOrders()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // orders
        viewModel.$orders.sink { [weak self] orders in
            DispatchQueue.main.async {
                self?.ordersTable.reloadData()
                
                if orders.isEmpty {
                    self?.emptyView.isHidden = false
                    self?.navigationItem.rightBarButtonItem?.isHidden = true
                } else {
                    self?.emptyView.isHidden = true
                    self?.navigationItem.rightBarButtonItem?.isHidden = false
                }
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(topSeparatorView)
        view.addSubview(ordersTable)
        view.addSubview(emptyView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let topSeparatorViewConstraints = [
            topSeparatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let ordersTableConstraints = [
            ordersTable.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            ordersTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ordersTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ordersTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        let emptyViewConstraints = [
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(ordersTableConstraints)
        NSLayoutConstraint.activate(emptyViewConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Orders"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
    }
}


//MARK: - UITableViewDelegate & DataSource
extension OrdersVC: UITableViewDelegate, UITableViewDataSource {
    // apply table delegates
    private func applyTableDelegates() {
        ordersTable.delegate = self
        ordersTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.orders[indexPath.row]
        
        if !model.isExpanded {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableCell.identifier) as? OrderTableCell else { return UITableViewCell()}
            cell.configure(with: model)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedOrderTableCell.identifier) as? ExpandedOrderTableCell else { return UITableViewCell() }
            cell.configure(with: model)
            return cell
        }
    }
    
    // cell height
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        viewModel.orders[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
