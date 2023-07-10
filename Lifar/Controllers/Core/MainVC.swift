//
//  MainVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit
import Combine
import FirebaseAuth

enum Sections: String {
    case topProducts = "Top Products"
    case newProdutcs = "New Products"
    case all = "All"
    case custom = "Custom"
}

class MainVC: UIViewController {
    
    //MARK: - ViewViewModel
    private var viewModel = MainViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - Data
    private let sectionsTitles = [Sections.topProducts, Sections.newProdutcs, Sections.all, Sections.custom]

    //MARK: - UI Objects
    private let sideMenu = SideMenuView()
    
    private let categoriesScrollView = CategoriesScrollView()
    
    private let mainTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .cakeWhite
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyTableDelegates()
        applySideMenuDelegate()
        // configure table
        configureMainTable()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth()
        configureNavBar()
        viewModel.retreiveCakes(for: CategoriesTabs.allCases[categoriesScrollView.selectedTabIndex])
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(categoriesScrollView)
        view.addSubview(mainTable)
        view.addSubview(sideMenu)
    }
    
    //MARK: - Bind views
    private func bindViews() {
        // side menu
        viewModel.$isSideMenuHidden.sink { [weak self] state in
            if state {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
                    self?.sideMenu.layer.opacity = 0
                } completion: { _ in }
                self?.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
                
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
                    self?.sideMenu.layer.opacity = 1
                } completion: { _ in }
        
                self?.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))?.rotate(degrees: 90)
            }
            
        }.store(in: &subscriptions)
        
        
        // cakes
        viewModel.$allCakes.sink { [weak self] cakes in
            DispatchQueue.main.async { [weak self] in
                self?.mainTable.reloadData()
            }
        }.store(in: &subscriptions)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let categoriesScrollViewConstraints = [
            categoriesScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            categoriesScrollView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let mainTableConstraints = [
            mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTable.topAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor, constant: 2),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let sideMenuConstraints = [
            sideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sideMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sideMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenu.widthAnchor.constraint(equalToConstant: 160)
        ]
        
        NSLayoutConstraint.activate(categoriesScrollViewConstraints)
        NSLayoutConstraint.activate(mainTableConstraints)
        NSLayoutConstraint.activate(sideMenuConstraints)
    }
    
    
    
    //MARK: - Handle Auth
    private func handleAuth() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: FirstWelcomeVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Liraf"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .black
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        navigationController?.navigationBar.backgroundColor = .cakeWhite
        
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: #selector(didTapSideMenu))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: #selector(didTapBasket))
        
        navigationItem.titleView = lifarLbl
    }
    
    //MARK: - Actions
    @objc private func didTapSideMenu() {
        viewModel.isSideMenuHidden.toggle()
    }
    
    @objc private func didTapBasket() {
        let vc = BasketVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }

}


//MARK: - UITableViewDelegate & DataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    private func applyTableDelegates() {
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    private func configureMainTable() {
        let footer = CallUsView(frame: CGRect(x: 0, y: 0, width: mainTable.frame.width, height: 120))
        mainTable.tableFooterView = footer
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.tintColor = .black
        header.textLabel?.font = UIFont(name: "Futura", size: 25)
        header.textLabel?.textColor = .black
        
        guard let firstLetterCapitalized = header.textLabel?.text?.first?.uppercased() else { return }
        header.textLabel?.text = header.textLabel?.text?.lowercased()
        header.textLabel?.text?.remove(at: header.textLabel!.text!.startIndex)
        header.textLabel?.text?.insert(contentsOf: firstLetterCapitalized, at: header.textLabel!.text!.startIndex)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier) as? MainCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        case 0:
            cell.configure(with: viewModel.popularCakes)
        case 1:
            cell.configure(with: viewModel.newCakes)
        case 2:
            cell.configure(with: viewModel.allCakes)
        case 3:
            let custom = Cake(title: CategoriesTabs.allCases[categoriesScrollView.selectedTabIndex].rawValue, path: "", price: "", description: "")
            cell.configure(with: [custom])
        default:
            return UITableViewCell()
        }
        
        //cell.backgroundColor = .clear
        return cell
    }
}


//MARK: - SideMenuDelegate
extension MainVC: SideMenuDelegate {
    private func applySideMenuDelegate() {
        sideMenu.delegate = self
    }
    
    func didSelectProfile() {
        print("PROFILE TAPPED")
        let vc = ProfileVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectOrders() {
        print("ORDERS TAPPED")
        let vc = OrdersVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectFavorite() {
        print("FAVORITE TAPPED")
        let vc = FavoriteVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectRate() {
        print("RATE TAPPED")
    }
    
    func didSelectShare() {
        print("SHARE TAPPED")
    }
    
    func didSelectAbout() {
        print("ABOUT TAPPED")
        let vc = AboutVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - MainCellDelegate
extension MainVC: MainCellDelegate {
    func didSelectItem(item: Cake) {
        
        let vc = ItemVC()
        vc.viewModel.item = item
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}
