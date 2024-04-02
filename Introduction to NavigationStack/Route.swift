//
//  Route.swift
//  Introduction to NavigationStack
//
//  Created by Danielle Lewis on 4/2/24.
//

import Foundation
import SwiftUI

enum Route: View, Hashable {
    case menuItem(item: any MenuItem)
    
    // Used to uniquley identify each case
    // This function says to use the hashValue as the unique identifier
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    // Allows us to compare if two cases are the same by comparing the id value
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.menuItem(let lhsItem), .menuItem(let rhsItem)):
            return lhsItem.id == rhsItem.id
        }
    }
    
    var body: some View {
        switch self {
        case .menuItem(let item):
            switch item {
            case is Food:
                FoodDetailView(food: item as! Food)
            case is Drink:
                DrinkDetailView(drink: item as! Drink)
            case is Dessert:
                DessertDetailView(dessert: item as! Dessert)
            default:
                EmptyView()
            }
        }
    }
}
