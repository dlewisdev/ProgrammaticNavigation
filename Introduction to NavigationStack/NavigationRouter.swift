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
    var routes = NavigationPath()
    
    func push(to screen: Route) {
        routes.append(screen)
    }
}
