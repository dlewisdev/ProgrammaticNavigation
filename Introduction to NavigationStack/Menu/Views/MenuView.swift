//
//  MenuView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 03/02/2023.
//

import SwiftUI

struct MenuView: View {
    
    @State private var routerManager = NavigationRouter()
    @StateObject private var cartManager = ShoppingCartManager()
    
    var body: some View {
        
        NavigationStack(path: $routerManager.routes) {
            
            List {
                
                Section("Foods") {
                    ForEach(foods) { food in
                        
                        NavigationLink(value: Route.menuItem(item: food)) {
                            MenuItemView(item: food)
                        }
                    }
                }
                
                Section("Drinks") {
                    ForEach(drinks) { drink in
                        
                        NavigationLink(value: Route.menuItem(item: drink)) {
                            MenuItemView(item: drink)
                        }
                    }
                }
                
                Section("Desserts") {
                    ForEach(desserts) { dessert in
                        
                        NavigationLink(value: Route.menuItem(item: dessert)) {
                            MenuItemView(item: dessert)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    CartButton(count: cartManager.items.count) {
                        
                    }
                }
            }
            .navigationTitle("Menu")
            .navigationDestination(for: Route.self) { route in
                switch route {
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
        .environmentObject(cartManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(ShoppingCartManager())
    }
}