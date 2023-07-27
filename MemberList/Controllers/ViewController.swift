//
//  ViewController.swift
//  MemberList
//
//  Created by Dowon Kim on 27/07/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // TableView
    private let tableView = UITableView()
    
    var memberListManager = MemberListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //❗️ it has to be called when the app launches so that it can access to the business model and pass the datas from the function to "private var memberList: [Member] = []"
        setupDatas()
        
        setupTableView()
        setupNaviBar()
        setupTableViewConstraints()
    }
    
    func setupTableView() {
        //❗️
        tableView.dataSource = self
        
        tableView.rowHeight = 60
    }
    
    func setupDatas() {
        memberListManager.makeMembersListDatas() // If ther's a server then it requires to server side
    }
    
    func setupNaviBar() {
        title = "List of members"
        
        // Setup Navigation Bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // A button on the upper right of the NavBar
        
        
    }
    
    // TableView's AutoLayout Setting
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor , constant:0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    

}

//❗️
extension ViewController: UITableViewDataSource {
    
    //❗️OBLIGATOIRE 1/2
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 5 //temporary return value
        return memberListManager.getMemberList().count
    }
    
    //❗️OBLIGATOIRE 2/2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //temporary return value
        return UITableViewCell()
    }
    
}
