//
//  Route.swift
//  Introduction to NavigationStack
//
//  Created by Danielle Lewis on 4/2/24.
//

import Foundation
import SwiftUI

enum Route {
    case menuItem(item: any MenuItem)
    case cart
    case ingredients(items: [Ingredient])
    case allergies(items: [Allergie])
    case locations(places: [Location])
    case map(location: Location)
}

extension Route: Hashable {
    
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
        case (.cart, .cart):
            return true
        case (.ingredients(let lhsItem), .ingredients(let rhsItem)):
            return lhsItem == rhsItem
        case (.allergies(let lhsItem), .allergies(let rhsItem)):
            return lhsItem == rhsItem
        case (.locations(let lhsItem), .locations(let rhsItem)):
            return lhsItem == rhsItem
        case (.map(let lhsItem), .map(let rhsItem)):
            return lhsItem.id == rhsItem.id
        default:
            return false
        }
    }
}

extension Route: View {
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
        case .cart:
            CartView()
        case .ingredients(let items):
            IngredientsDetailView(ingredients: items)
        case .allergies(let items):
            AllergiesDetailView(allergies: items)
        case .locations(let places):
            LocationsDetailView(locations: places)
        case .map(let location):
            LocationMapView(location: location)
        }
    }
}
