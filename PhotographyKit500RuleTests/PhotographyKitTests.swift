//
//  PhotographyKitTests.swift
//  PhotographyKitTests
//
//  Created by peerapat atawatana on 5/15/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import XCTest
@testable import PhotographyKit

class PhotographyKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test500RuleFunction() {
        let viewModel = FiveHundredRuleViewModel()
        viewModel.calculate500Rule(focalLength: 28, cropFactor: 1.5)
        XCTAssertEqual(viewModel.resultTime, (500/28)/1.5)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
