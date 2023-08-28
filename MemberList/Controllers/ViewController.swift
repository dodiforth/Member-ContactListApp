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
    
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
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
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    func setupDatas() {
        memberListManager.makeMembersListDatas()
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
        
        // A button on the upper right of the NavBar (Plus Button)
        self.navigationItem.rightBarButtonItem = self.plusButton
        
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
    
    // jump to another view to create(add) a member
    @objc func plusButtonTapped(){
        // jump to another view (it doesn't pass a data of members)
        let detailVC = DetailViewController()
        
        detailVC.delegate = self
        
        // jump to another view
        navigationController?.pushViewController(detailVC, animated: true)
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
        cell.memeber = memberListManager[indexPath.row]
        cell.selectionStyle = .none
        
        //return UITableViewCell() //temporary return value
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code which leads to another view
        let detailVC = DetailViewController()
        
        detailVC.delegate = self
        
        //pass datas of selected member's info to the next view(Detail View)
        let currentMember = memberListManager.getMemberList()[indexPath.row]
        detailVC.member = currentMember
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

// Custom Delegate
extension ViewController: MemeberDelegate {
    func addNewMember(_ member: Member) {
        memberListManager.makeNewMember(member)
        tableView.reloadData()
    }
    
    func updateMember(index: Int, _ member: Member) {
        memberListManager.updateMemberInfo(index: index, member)
        tableView.reloadData()
    }
}
