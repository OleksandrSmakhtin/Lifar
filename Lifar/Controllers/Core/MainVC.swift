//
//  MainVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 24.05.2023.
//

import UIKit
import Combine


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
        view.backgroundColor = .cakePink
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyDelegates()
        // configure table
        configureMainTable()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        //UserDefaults.standard.set(false, forKey: "isOnboarded")
        //
        
        
        if !UserDefaults.standard.bool(forKey: "isOnboarded") {
            let vc = UINavigationController(rootViewController: FirstWelcomeVC())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
        
        viewModel.retrieveCakes(for: CategoriesTabs.allCases[categoriesScrollView.selectedTabIndex])
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(categoriesScrollView)
        view.addSubview(mainTable)
    }
    
    //MARK: - Bind views
    private func bindViews() {
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
            categoriesScrollView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let mainTableConstraints = [
            mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTable.topAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor, constant: 20),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(categoriesScrollViewConstraints)
        NSLayoutConstraint.activate(mainTableConstraints)
    }
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Liraf"
            lbl.font = UIFont(name: "Chalkboard SE", size: 30)
            lbl.textColor = .cakeWhite
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
        }()
        
        navigationController?.navigationBar.tintColor = .cakeWhite
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "basket", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .plain, target: self, action: #selector(ttt))
        
        navigationItem.titleView = lifarLbl
    }
    
    @objc func ttt() {
        print(viewModel.allCakes.count)
    }

}

//MARK: - UITableViewDelegate & DataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    private func applyDelegates() {
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    private func configureMainTable() {
        let footer = MainTableFooter(frame: CGRect(x: 0, y: 0, width: mainTable.frame.width, height: 120))
        mainTable.tableFooterView = footer
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.tintColor = .cakePink
        header.textLabel?.font = UIFont(name: "Futura", size: 25)
        header.textLabel?.textColor = .cakeWhite
        
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier) as? MainCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.configure(with: viewModel.popularCakes)
        case 1:
            cell.configure(with: viewModel.newCakes)
        case 2:
            cell.configure(with: viewModel.allCakes)
        case 3:
            cell.configure(with: viewModel.newCakes)
        default:
            return UITableViewCell()
        }
        
        //cell.backgroundColor = .clear
        return cell
    }
}
