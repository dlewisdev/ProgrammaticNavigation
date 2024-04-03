//
//  RouteManagerTests.swift
//  IntroductiontoNavigationStackTests
//
//  Created by Danielle Lewis on 4/3/24.
//

import XCTest
@testable import Introduction_to_NavigationStack

final class RouteManagerTests: XCTestCase {

    private var sut: NavigationRouter!
    
    override func setUp() {
        sut = NavigationRouter()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testRouteIsEmptyOnInitialization() {
        XCTAssertEqual(sut.routes.count, 0, "There should be 0 routes in the stack")
    }
    
    func testPushingOneScreenHasOneRoute() {
        sut.push(to: .menuItem(item: foods[0]))
        XCTAssertEqual(sut.routes.count, 1, "There should be 1 route in the stack")
    }
    
    func testPushingTwoScreensHasTwoRoutes() {
        sut.push(to: .menuItem(item: foods[0]))
        sut.push(to: .cart)
        XCTAssertEqual(sut.routes.count, 2, "There should be 2 routes in the stack")
    }
    
    func testResettingRoutesHasNoRoutes() {
        sut.push(to: .menuItem(item: foods[0]))
        sut.push(to: .cart)
        sut.reset()
        XCTAssertEqual(sut.routes.count, 0, "There should be 0 routes in the stack")
    }
    
    func testGoingBackHasOneRoute() {
        sut.push(to: .menuItem(item: foods[0]))
        sut.push(to: .cart)
        sut.goBack()
        XCTAssertEqual(sut.routes.count, 1, "There should be 1 route in the stack")
    }
}
