//
//  MockResearchTests.swift
//  MockResearchTests
//
//  Created by Rod Tavangar on 8/31/25.
//

import Testing
import SwiftUI
@testable import MockResearch

// MARK: - User Model Tests
struct UserTests {
    @Test("User initialization with default values")
    func testDefaultInitialization() {
        let user = User()
        
        #expect(user.firstName == "")
        #expect(user.lastName == "")
        #expect(user.email == "")
        #expect(user.phoneNumber == "")
        #expect(user.currentRegion == "")
        #expect(user.dob == nil)
    }
    
    @Test("User initialization with custom values")
    func testCustomInitialization() {
        let date = Date()
        let user = User(
            firstName: "John",
            lastName: "Doe",
            dob: date,
            email: "john@example.com",
            phoneNumber: "555-1234",
            currentRegion: "US"
        )
        
        #expect(user.firstName == "John")
        #expect(user.lastName == "Doe")
        #expect(user.dob == date)
        #expect(user.email == "john@example.com")
        #expect(user.phoneNumber == "555-1234")
        #expect(user.currentRegion == "US")
    }
    
    @Test("User hasNullField method")
    func testHasNullField() {
        let emptyUser = User()
        #expect(emptyUser.hasNullField() == true)
        
        let partialUser = User(firstName: "John", lastName: "Doe")
        #expect(partialUser.hasNullField() == true)
        
        let completeUser = User(
            firstName: "John",
            lastName: "Doe",
            dob: Date(),
            email: "john@example.com",
            phoneNumber: "555-1234",
            currentRegion: "US"
        )
        #expect(completeUser.hasNullField() == false)
    }
    
    @Test("User equality")
    func testEquality() {
        let date = Date()
        let user1 = User(
            firstName: "John",
            lastName: "Doe",
            dob: date,
            email: "john@example.com",
            phoneNumber: "555-1234",
            currentRegion: "US"
        )
        
        let user2 = User(
            firstName: "John",
            lastName: "Doe",
            dob: date,
            email: "john@example.com",
            phoneNumber: "555-1234",
            currentRegion: "US"
        )
        
        let user3 = User(
            firstName: "Jane",
            lastName: "Doe",
            dob: date,
            email: "jane@example.com",
            phoneNumber: "555-5678",
            currentRegion: "CA"
        )
        
        #expect(user1 == user2)
        #expect(user1 != user3)
    }
}

// MARK: - ContentViewModel Tests
struct ContentViewModelTests {
    @Test("ContentViewModel initialization")
    func testInitialization() {
        let viewModel = ContentViewModel()
        
        #expect(viewModel.user.firstName == "")
        #expect(viewModel.user.lastName == "")
        #expect(viewModel.user.email == "")
    }
    
    @Test("ContentViewModel user modification")
    func testUserModification() {
        let viewModel = ContentViewModel()
        
        viewModel.user.firstName = "John"
        viewModel.user.lastName = "Doe"
        viewModel.user.email = "john@example.com"
        
        #expect(viewModel.user.firstName == "John")
        #expect(viewModel.user.lastName == "Doe")
        #expect(viewModel.user.email == "john@example.com")
    }
}

// MARK: - View Component Tests
struct ViewComponentTests {
    @Test("TabHeaderView initialization")
    func testTabHeaderViewInit() {
        let user = User(firstName: "Test", lastName: "User")
        
        let _ = TabHeaderView(
            title: "Test Title",
            showProfileScreen: .constant(false),
            user: user
        )
        
        // Test passes if view initializes without error
        #expect(true)
    }
    
    @Test("LegalSection initialization")
    func testLegalSectionInit() {
        let _ = LegalSection(
            showResearchAndPrivacySheet: .constant(false)
        )
        
        // Test passes if view initializes without error
        #expect(true)
    }
}
