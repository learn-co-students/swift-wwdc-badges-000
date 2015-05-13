//
//  swift_wwdc_badgesTests.swift
//  swift-wwdc-badgesTests
//
//  Created by Joe Burgess on 11/21/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

import UIKit
import XCTest
import swift_wwdc_badges

class swift_wwdc_badgesTests: XCTestCase {
    
    let badgeString: String = "Hello, my name is"
    
    let expectedSpeakers: [String] = ["Edsger", "Ada", "Charles", "Alan", "Grace", "Linus", "Wozniak"]
    let unexpectedSpeakers: [String] = ["Bill Clinton", "John Forstall", "Wayne Brady"]
    
    var testAppDelegate: AppDelegate?
    var testingSpeakers: [String]?
    
    override func setUp() {
        super.setUp()
        testAppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        testingSpeakers = testAppDelegate!.conferenceSpeakers
    }
    
    func testThatAppDelegateExists() {
        XCTAssertNotNil(testAppDelegate, "AppDelegate should exist")
        XCTAssertNotNil(testingSpeakers, "AppDelegate should have speakers")
    }
    
    func testArrayMembership() {
        
        let invitedSpeakers: NSArray = expectedSpeakers.sorted { $0 > $1 }
        let uninvitedSpeakers: NSArray = unexpectedSpeakers.sorted { $0 > $1 }
        
        let actualSpeakers: NSArray = testingSpeakers!.sorted { $0 > $1 }

        XCTAssertTrue(invitedSpeakers.isEqualToArray(actualSpeakers as! [String]), "It should have the correct speakers")
        XCTAssertFalse(uninvitedSpeakers.isEqualToArray(actualSpeakers as! [String]), "It should not have uninvited speakers")
    
    }
    
    func testForTotalAttendants() {
        
        let correctCount = expectedSpeakers.count
        let actualCount = testingSpeakers!.count
        
        XCTAssertEqual(correctCount, actualCount, "It should return the correct number of speakers")
        
    }
    
    func testDefaultStringExtraCredit() {
        
        var expectedDefaultBadgesMade: [String] = []
        for guest in expectedSpeakers {
            expectedDefaultBadgesMade.append("\(badgeString) \(guest)")
        }
        
        let actualDefaultBadgesMade = testAppDelegate!.printBadges(forGuests: testAppDelegate!.conferenceSpeakers).sorted{ $0 > $1 }
        let expectedAndSortedBadges = expectedDefaultBadgesMade.sorted{ $0 > $1 }
        
        XCTAssertTrue(actualDefaultBadgesMade == expectedAndSortedBadges, "It should generate the correct badges for a defaulted string")
    }
    
    func testExplicitStringExtraCredit() {
        
        var expectedDefaultBadgesMade: [String] = []
        for guest in expectedSpeakers {
            expectedDefaultBadgesMade.append("\(badgeString) \(guest)")
        }
        
        let actualDefaultBadgesMade = testAppDelegate!.printBadges(forGuests: testAppDelegate!.conferenceSpeakers, withMessage: badgeString).sorted{ $0 > $1 }
        let expectedAndSortedBadges = expectedDefaultBadgesMade.sorted{ $0 > $1 }

        XCTAssertTrue(actualDefaultBadgesMade == expectedAndSortedBadges, "It should generate the correct badges when explicitly passing a message")
    }
    
}
