//
//  User.swift
//  MockResearch
//
//  Created by Rod Tavangar on 8/31/25.
//

import Foundation

struct User: Equatable {
    var firstName: String = ""
    var lastName: String = ""
    var dob: Date? = nil
    var email: String = ""
    var phoneNumber: String = ""
    var currentRegion: String = ""
    
    func hasNullField() -> Bool {
        return firstName.isEmpty ||
        lastName.isEmpty ||
        dob == nil ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        currentRegion.isEmpty
    }
}
