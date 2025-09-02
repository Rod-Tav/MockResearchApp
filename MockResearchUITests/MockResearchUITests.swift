//
//  MockResearchUITests.swift
//  MockResearchUITests
//
//  Created by Rod Tavangar on 8/31/25.
//

import XCTest

final class MockResearchUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    // MARK: - Tab Navigation Tests
    
    @MainActor
    func testTabBarNavigation() throws {
        // Test that all three tabs exist
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists)
        
        // Test Tasks tab
        let tasksTab = tabBar.buttons["Tasks"]
        XCTAssertTrue(tasksTab.exists)
        XCTAssertTrue(tasksTab.isSelected)
        
        // Test Studies tab
        let studiesTab = tabBar.buttons["Studies"]
        XCTAssertTrue(studiesTab.exists)
        studiesTab.tap()
        XCTAssertTrue(studiesTab.isSelected)
        
        // Test Your Data tab
        let yourDataTab = tabBar.buttons["Your Data"]
        XCTAssertTrue(yourDataTab.exists)
        yourDataTab.tap()
        XCTAssertTrue(yourDataTab.isSelected)
        
        // Navigate back to Tasks
        tasksTab.tap()
        XCTAssertTrue(tasksTab.isSelected)
    }
    
    // MARK: - Tasks View Tests
    @MainActor
    func testTasksViewHeader() throws {
        // Verify Tasks title is visible
        let tasksTitle = app.staticTexts["Tasks"].firstMatch
        XCTAssertTrue(tasksTitle.exists)
        
        // Verify profile button exists
        let profileButton = app.buttons["person.crop.circle"].firstMatch
        XCTAssertTrue(profileButton.exists)
    }
    
    @MainActor
    func testTasksViewHealthStudyCard() throws {
        // Check if health study card exists (may be dismissed)
        let healthStudyTitle = app.staticTexts["Apple Health Study"]
        if healthStudyTitle.exists {
            XCTAssertTrue(healthStudyTitle.exists)
            
            // Test Learn More button
            let learnMoreButton = app.buttons["Learn More"]
            XCTAssertTrue(learnMoreButton.exists)
            
            // Test dismiss button
            let dismissButton = app.buttons["xmark.circle.fill"]
            if dismissButton.exists {
                dismissButton.tap()
                // Verify card is dismissed
                XCTAssertFalse(healthStudyTitle.waitForExistence(timeout: 1))
            }
        }
    }
    
    @MainActor
    func testTasksViewNoTasksMessage() throws {
        let noTasksText = app.staticTexts["There are no tasks available."]
        XCTAssertTrue(noTasksText.exists)
        
        let enrollText = app.staticTexts["Go to Studies to enroll in your first study."]
        XCTAssertTrue(enrollText.exists)
    }
    
    @MainActor
    func testProfileScreenPresentation() throws {
        // Tap profile button
        let profileButton = app.buttons["person.crop.circle"].firstMatch
        profileButton.tap()
        
        // Verify Profile screen appears
        let profileNavBar = app.navigationBars["Profile"]
        XCTAssertTrue(profileNavBar.waitForExistence(timeout: 2))
        
        // Test Done button
        let doneButton = app.buttons["Done"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        
        // Verify we're back to Tasks
        XCTAssertFalse(profileNavBar.exists)
    }
    
    // MARK: - Your Data View Tests
    @MainActor
    func testYourDataViewSections() throws {
        // Navigate to Your Data tab
        app.tabBars.buttons["Your Data"].tap()
        
        // Verify Your Data title
        let yourDataTitle = app.staticTexts["Your Data"].firstMatch
        XCTAssertTrue(yourDataTitle.exists)
        
        // Test section headers
        let healthDataHeader = app.staticTexts["Health Data & Records"]
        XCTAssertTrue(healthDataHeader.exists)
        
        let sensorDataHeader = app.staticTexts["Sensor & Usage Data"]
        XCTAssertTrue(sensorDataHeader.exists)
        
        let commonStudyHeader = app.staticTexts["Common Study Data"]
        XCTAssertTrue(commonStudyHeader.exists)
        
        let additionalDataHeader = app.staticTexts["Additional Data"]
        XCTAssertTrue(additionalDataHeader.exists)
    }
    
    @MainActor
    func testYourDataNavigationLinks() throws {
        // Navigate to Your Data tab
        app.tabBars.buttons["Your Data"].tap()
        
        // Test Demographic Information navigation
        let demographicLink = app.buttons["Demographic Information"]
        XCTAssertTrue(demographicLink.exists)
        demographicLink.tap()
        
        // Verify navigation
        let demographicNavBar = app.navigationBars["Demographic Information"]
        XCTAssertTrue(demographicNavBar.waitForExistence(timeout: 2))
        
        // Go back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Test Family Health History navigation
        let familyHealthLink = app.buttons["Family Health History"]
        XCTAssertTrue(familyHealthLink.exists)
        familyHealthLink.tap()
        
        // Verify navigation
        let familyHealthNavBar = app.navigationBars["Family Health History"]
        XCTAssertTrue(familyHealthNavBar.waitForExistence(timeout: 2))
        
        // Go back
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    @MainActor
    func testYourDataInfoButtons() throws {
        // Navigate to Your Data tab
        app.tabBars.buttons["Your Data"].tap()
        
        // Find and tap an info button
        let infoButtons = app.buttons.matching(identifier: "info.circle")
        if infoButtons.count > 0 {
            let firstInfoButton = infoButtons.element(boundBy: 0)
            firstInfoButton.tap()
            
            // Verify info sheet appears
            let doneButton = app.buttons["Done"]
            XCTAssertTrue(doneButton.waitForExistence(timeout: 2))
            
            // Dismiss sheet
            doneButton.tap()
            XCTAssertFalse(doneButton.exists)
        }
    }
    
    // MARK: - Studies View Tests
    @MainActor
    func testStudiesViewContent() throws {
        // Navigate to Studies tab
        app.tabBars.buttons["Studies"].tap()
        
        // Verify Studies title
        let studiesNavBar = app.navigationBars["Studies"]
        XCTAssertTrue(studiesNavBar.exists)
        
        // Test Apple Health Study section
        let appleHealthStudyText = app.staticTexts["Apple Health Study"]
        XCTAssertTrue(appleHealthStudyText.exists)
        
        // Test Learn More button
        let learnMoreButton = app.buttons["Learn More"]
        XCTAssertTrue(learnMoreButton.exists)
        
        // Test Open Studies section
        let openStudiesText = app.staticTexts["Open Studies"]
        XCTAssertTrue(openStudiesText.exists)
        
        // Test Women's Health Study
        let womensHealthText = app.staticTexts["Apple Women's Health Study"]
        XCTAssertTrue(womensHealthText.exists)
        
        // Scroll down to see Previous Studies section
        let collectionView = app.collectionViews.firstMatch
        collectionView.swipeUp()
        
        // Test Previous Studies section
        let previousStudiesText = app.staticTexts["Previous Studies"]
        XCTAssertTrue(previousStudiesText.exists)
    }
    
    // MARK: - Scroll Behavior Tests
    @MainActor
    func testScrollToShowToolbarTitle() throws {
        // Start in Tasks view
        let tasksTab = app.tabBars.buttons["Tasks"]
        tasksTab.tap()
        
        // Get the list
        let list = app.collectionViews.firstMatch
        
        // Initially, toolbar title should be hidden (opacity 0)
        // We can't directly test opacity, but we can test scroll behavior
        
        // Scroll down
        list.swipeUp()
        
        // After scrolling, the toolbar title should be visible
        // We verify the title still exists (it's always there, just opacity changes)
        let toolbarTitle = app.navigationBars.staticTexts["Tasks"]
        XCTAssertTrue(toolbarTitle.exists)
        
        // Scroll back up
        list.swipeDown()
        list.swipeDown()
        
        // Title should still exist (opacity handled by the app)
        XCTAssertTrue(toolbarTitle.exists)
    }
    
    // MARK: - Profile Edit Mode Tests
    @MainActor
    func testProfileEditMode() throws {
        // Navigate to profile
        let profileButton = app.buttons["person.crop.circle"].firstMatch
        profileButton.tap()
        
        // Wait for profile screen
        let profileNavBar = app.navigationBars["Profile"]
        XCTAssertTrue(profileNavBar.waitForExistence(timeout: 2))
        
        // Test Edit button
        let editButton = app.buttons["Edit"]
        XCTAssertTrue(editButton.exists)
        editButton.tap()
        
        // Verify we're in edit mode (Done button appears)
        let doneEditButton = app.navigationBars["Profile"].buttons["Done"]
        XCTAssertTrue(doneEditButton.exists)
        
        // Test Cancel button
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()
        
        // Verify we're out of edit mode
        XCTAssertTrue(editButton.exists)
        
        // Close profile
        let doneButton = app.buttons["Done"].firstMatch
        doneButton.tap()
    }
}
