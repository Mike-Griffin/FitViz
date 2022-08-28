//
//  DateExtensionTests.swift
//  FitVizTests
//
//  Created by Mike Griffin on 8/28/22.
//

import XCTest
@testable import FitViz

final class DateExtensionTests: XCTestCase {
    func testTimeOfDayAM() throws {
        let date = try stringToDate("May 26, 2022 at 8:30 AM")
        let timeOfDay = date.timeOfDay()
        XCTAssert(timeOfDay == .AM)
    }
    
    func testTimeOfDayPM() throws {
        let date = try stringToDate("Aug 28, 2022 at 12:00 PM")
        XCTAssert(date.timeOfDay() == .PM)
        let almostMidnight = try stringToDate("Jan 1, 2022 at 11:59 PM")
        XCTAssert(almostMidnight.timeOfDay() == .PM)
    }
    
    func stringToDate(_ val: String) throws -> Date {
        let strategy = Date.FormatStyle().month().year().day().hour().minute()
        return try Date(val, strategy: strategy)
    }

}
