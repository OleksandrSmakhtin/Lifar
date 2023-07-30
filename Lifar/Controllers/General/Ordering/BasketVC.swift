//
//  BasketVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import UIKit
import Combine

class BasketVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = BasketViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let basketTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BasketTableCell.self, forCellReuseIdentifier: BasketTableCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let basketTableFooterView = OfferTableFooterView()
    
    private let stickyOfferView = StickyOfferView()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .cakeWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyView = EmptyView()
    
    //MARK: - Actions
    @objc private func didTapDeleteAll() {
        presentDeletionAlert()
    }
    
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
        // configure table
        configureTable()
        // apply delegates
        applyTableDelegates()
        applyEmptyViewDelegate()
        applyCheckoutDelegate()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retreiveBasket()
    }
    
    //MARK: - BindViews
    private func bindViews() {
        // price
        viewModel.$moneySum.sink { [weak self] sum in
            self?.basketTableFooterView.priceLbl.text = "€\(sum)0"
            self?.stickyOfferView.priceLbl.text = "€\(sum)0"
        }.store(in: &subscriptions)
        
        // amount
        viewModel.$amountForOrder.sink { [weak self] amount in
            self?.basketTableFooterView.amountToOrderLbl.text = "\(amount)"
        }.store(in: &subscriptions)
        
        // bind items
        viewModel.$items.sink { [weak self] items in
            DispatchQueue.main.async {
                self?.basketTable.reloadData()
                
                if items.isEmpty {
                    self?.emptyView.isHidden = false
                    self?.basketTable.isHidden = true
                    self?.navigationItem.rightBarButtonItem?.isHidden = true
                } else {
                    self?.emptyView.isHidden = true
                    self?.basketTable.isHidden = false
                    self?.navigationItem.rightBarButtonItem?.isHidden = false
                    
                    self?.viewModel.countOrder()
                }
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(topSeparatorView)
        view.addSubview(basketTable)
        view.addSubview(emptyView)
        view.addSubview(stickyOfferView)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let topSeparatorViewConstraints = [
            topSeparatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let basketTableConstraints = [
            basketTable.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            basketTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basketTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            basketTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let emptyViewConstraints = [
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let stickyOfferViewConstraints = [
            stickyOfferView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stickyOfferView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stickyOfferView.heightAnchor.constraint(equalToConstant: 80),
            stickyOfferView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(topSeparatorViewConstraints)
        NSLayoutConstraint.activate(basketTableConstraints)
        NSLayoutConstraint.activate(emptyViewConstraints)
        NSLayoutConstraint.activate(stickyOfferViewConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Basket"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        navigationController?.navigationBar.backgroundColor = .cakeWhite
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = lifarLbl
        
        let clearAllLbl: UIButton = {
            let btn = UIButton(type: .system)
            btn.tintColor = .systemRed
            btn.setTitle("Clear All", for: .normal)
            btn.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
            btn.addTarget(self, action: #selector(didTapDeleteAll), for: .touchUpInside)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: clearAllLbl)
    }
    
    
    //MARK: - Present alert
    private func presentDeletionAlert() {
        
        let alert = UIAlertController(title: "Deleting", message: "Are you sure you want to delete all items in your basket?", preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: "YES", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteAll()
            self?.viewModel.items.removeAll()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(positiveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
        
        
    }
}


//MARK: - UITableViewDelegate & DataSource
extension BasketVC: UITableViewDelegate, UITableViewDataSource, BasketTableCellDelegate {
    // configure table
    private func configureTable() {
        basketTableFooterView.frame = CGRect(x: 0, y: 0, width: basketTable.frame.width, height: 300)
        basketTable.tableFooterView = basketTableFooterView
    }
    
    // table delegates
    private func applyTableDelegates() {
        basketTable.delegate = self
        basketTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableCell.identifier) as? BasketTableCell else { return UITableViewCell() }
        
        let model = viewModel.items[indexPath.row]
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
    // should upate row
    func shouldUpdateRow() {
        viewModel.retreiveBasket()
    }
    
    // scroll view did scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition >  scrollView.contentSize.height - scrollView.bounds.size.height - 200 {
                           
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.stickyOfferView.layer.opacity = 0
            } completion: { _ in }
            
                self.stickyOfferView.isHidden = true
                        
        } else if yPosition < scrollView.contentSize.height - scrollView.bounds.size.height - 10 {
        
                self.stickyOfferView.isHidden = false
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.stickyOfferView.layer.opacity = 1
            } completion: { _ in }
            
        }
    }
    
}

//MARK: - EmptyViewDelegate
extension BasketVC: EmptyViewDelegate {
    private func applyEmptyViewDelegate() {
        emptyView.delegate = self
    }
    
    func didTapGoToPtoducts() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - CheckoutDelegate
extension BasketVC: CheckoutDelegate {
    private func applyCheckoutDelegate() {
        stickyOfferView.delegate = self
        basketTableFooterView.delegate = self
    }
    
    func didTapOrder() {
        let vc = CheckoutVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }
}
