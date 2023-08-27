//
//  MemberListManager.swift
//  MemberList
//
//  Created by Dowon Kim on 27/07/2023.
//

import UIKit

final class MemberListManager {
    
    private var memberList: [Member] = []
    
    func makeMembersListDatas() {

            memberList = [
            Member(name: "batman", age: 27, phone: "+1-202-555-0161", address: "Gotham City"),
            Member(name: "elonmusk", age: 52, phone: "+1-202-555-0162", address: "California"),
            Member(name: "jeffbezos", age: 59, phone: "+1-202-555-0163", address: "California"),
            Member(name: "joker", age: 44, phone: "+1-202-555-0164", address: "Gotham City"),
            Member(name: "mortysanchez", age: 14, phone: "+1-202-555-0165", address: "Washington"),
            Member(name: "picklerick", age: 70, phone: "+1-202-555-0166", address: "Washington"),
            Member(name: "ricksanchez", age: 70, phone: "+1-202-555-0167", address: "Washington"),
            Member(name: "steve", age: 56, phone: "+1-202-555-0168", address: "California"),
            Member(name: "tim", age: 62, phone: "+1-202-555-0169", address: "California")
            ]
            
        }
    
    // Get all the members in the list
    func getMemberList() -> [Member] {
        return memberList
    }
    
    // Create a new member
    func makeNewMember(_ member: Member) {
        memberList.append(member)
    }
    
    // Update info of a memeber already existing
    func updateMemberInfo(index: Int, _ member: Member) {
        memberList[index] = member
    }
    
    // Get a specific member info
    subscript(index: Int) -> Member {
        get {
            return memberList[index]
        }
        set {
            memberList[index] = newValue
        }
    }
        
    }
    

