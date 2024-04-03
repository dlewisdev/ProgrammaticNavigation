//
//  NavigationRouter.swift
//  Introduction to NavigationStack
//
//  Created by Danielle Lewis on 4/2/24.
//

import Foundation
import SwiftUI

@Observable
final class NavigationRouter {
    var routes = [Route]()
    
    func push(to screen: Route) {
        routes.append(screen)
    }
    
    func reset() {
        routes = []
    }
    
    func goBack() {
        // Benefit of using an array, you can just remove the last item in the array to programmatically go back to the previous view
        _ = routes.popLast()
    }
}
