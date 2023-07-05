//
//  ProfileVC.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 20.06.2023.
//

import UIKit
import Combine
import Firebase
import FirebaseAuth

class ProfileVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = ProfileViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let greetingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let profileTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    //MARK: viewDidLoad
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
        // bind views
        bindViews()
        // apply delegates
        configureProfileTable()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // retreive user
        viewModel.retreiveUser()
    }
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$name.sink { [weak self] name in
            guard let name = name else { return }
            self?.greetingsLbl.text = "Hello, \(name)"
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(greetingsLbl)
        view.addSubview(profileTable)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let greetingsLblConstraints = [
            greetingsLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            greetingsLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            greetingsLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let profileTableConstraints = [
            profileTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTable.topAnchor.constraint(equalTo: greetingsLbl.bottomAnchor, constant: 40),
            profileTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(greetingsLblConstraints)
        NSLayoutConstraint.activate(profileTableConstraints)
    }
    
    //MARK: - Show alert
    private func showAlert(with title: String, and message: String, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: "YES", style: .destructive) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(positiveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        let lifarLbl: UILabel = {
            let lbl = UILabel()
            lbl.text = "Profile"
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
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    // table delegates
    private func configureProfileTable() {
        
        let footerView = DeleteAccountView(frame: CGRect(x: 0, y: 0, width: profileTable.frame.width, height: 120))
        footerView.delegate = self
        profileTable.tableFooterView = footerView
        
        profileTable.delegate = self
        profileTable.dataSource = self
    }
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.profileMenuItems.count
    }
    
    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier) as? ProfileCell else { return UITableViewCell() }
        cell.configure(with: viewModel.profileMenuItems[indexPath.row])
        
        if indexPath.row == viewModel.profileMenuItems.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 2000, bottom: 0, right: 0)
        }
        return cell
    }
    
    // height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        switch indexPath.row {
        case 0:
            print("Change name pressed")
        case 1:
            print("Change email pressed")
        case 2:
            print("Change password pressed")
        case 3:
            print("Change delivery pressed")
        case 4:
            print("Contact pressed")
        case 5:
            print("Sign out pressed")
            showAlert(with: "Signing Out", and: "Are you sure, you want to sign out?") { [weak self] in
                try? Auth.auth().signOut()
                self?.navigationController?.popViewController(animated: false)
            }
        default:
            return
        }
        
    }
}

//MARK: - DeleteAccountViewDelegate
extension ProfileVC: DeleteAccountViewDelegate {
    func didTapDeleteAccountBtn() {
        print("DELETE ACCOUNT PRESSED")
        
        showAlert(with: "Deletion", and: "Are you sure, you want to delete an account?") { [weak self] in
            self?.viewModel.deleteUser()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
