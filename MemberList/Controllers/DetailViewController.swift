//
//  DetailViewController.swift
//  MemberList
//
//  Created by Dowon Kim on 27/07/2023.
//

import UIKit
import PhotosUI

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
        setupTapGestures()
    }
    
    private func setupData() {
        detailView.member = member
    }
    
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Set function when the imageView is pressed
    
    // Set the gesture(execute when the imageView is pressed) -> 제스쳐 !!!!
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        detailView.mainImageView.addGestureRecognizer(tapGesture)
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        // default setting, iOS 14.0 required!!!!!
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        // PickerViewController with default setting
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        print("save or update button is pressed")
        
        // [1] If a memeber doesn't exist (or Save a new memeber profile)
        if member == nil {
            //No input leads to empty String ""
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            let phoneNumber = detailView.phoneNumberTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            //Create(Add) a new Member
            var newMember =
            Member(name: name, age: age, phone: phoneNumber, address: address)
            newMember.memberImage = detailView.mainImageView.image
            
            // ⭐️
            let index = navigationController!.viewControllers.count - 2
            // access to the previous view
            let vc = navigationController?.viewControllers[index] as! ViewController
            // access to the previous view and add a member
            vc.memberListManager.makeNewMember(newMember)
            print("SAVE")
            
            // [2] If a memeber exist (or Update a member's profile)
        } else {
            member?.memberImage = detailView.mainImageView.image
            
            let memberId = Int(detailView.memberIdTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "") ?? 0
            member!.phone = detailView.phoneNumberTextField.text ?? ""
            member!.address = detailView.addressTextField.text ?? ""
            
            //Pass to the View memeber's changed status(profile) (View Controller ==> View)
            detailView.member = member
            
            // ⭐️
            let index = navigationController!.viewControllers.count - 2
            // access to the previous view
            let vc = navigationController?.viewControllers[index] as! ViewController
            // access to the previous view and update the member
            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            print("Update")
        }
        // After the task, Going back to the previous view(source view)
        self.navigationController?.popViewController(animated: true)
    }

}

// 🤳 Let the user select the images of member from their Library
extension DetailViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // picker view dismiss
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self){ (image, error) in
                
                DispatchQueue.main.async {
                    self.detailView.mainImageView.image = image as? UIImage
                }
                
            }
        } else {
            print("Can't bring images source!(or cancel changing image)")
        }
    }
    
    
}
