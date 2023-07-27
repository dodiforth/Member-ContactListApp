//
//  DetailViewController.swift
//  MemberList
//
//  Created by Dowon Kim on 27/07/2023.
//

import UIKit

final class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    var member: Member?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonAction()
        setupData()
    }
    
    private func setupData() {
        detailView.member = member
    }
    
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        print("Button is pressed")
    }

}
