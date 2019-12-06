//
//  TWiOSMoviesAppTests.swift
//  TWiOSMoviesAppTests
//
//  Created by Bushra Sagir on 11/15/19.
//  Copyright © 2019 bushraSagir. All rights reserved.
//

import XCTest
@testable import TWiOSMoviesApp

class TWiOSMoviesAppTests: XCTestCase {
    var movieViewController: MoviesViewController?
    override func setUp() {
      movieViewController = MoviesViewController()
      XCUIApplication().launch()
  }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoviesCount() {
        XCTAssertTrue(movieViewController?.collectionView.numberOfItems(inSection: 0) == 6)
    }

  func testTitle() {
    XCTAssertTrue(movieViewController?.navigationItem.title == "Movies")
  }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
