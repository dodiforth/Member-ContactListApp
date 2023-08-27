//
//  member.swift
//  MemberList
//
//  Created by Dowon Kim on 27/07/2023.
//

import UIKit

struct Member {
    
    lazy var memberImage: UIImage? = {
        
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    //Follow up member's current number and it can give out memberId according to current number's of the members.
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        self.memberId = Member.memberNumbers
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        //if user creates a new member
        Member.memberNumbers += 1
    }
}
