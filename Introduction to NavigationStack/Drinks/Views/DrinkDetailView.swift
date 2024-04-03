//
//  DrinkDetailView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 04/02/2023.
//

import SwiftUI

struct DrinkDetailView: View {
    
    @EnvironmentObject private var cartManager: ShoppingCartManager
    @Environment(NavigationRouter.self) private var routerManager: NavigationRouter

    let drink: Drink
    
    var body: some View {
        List {
            
            Section {
                LabeledContent("Icon", value: drink.name)
                LabeledContent("Name", value: drink.title)
                LabeledContent {
                    Text(drink.price,
                         format: .currency(code: Locale.current.currency?.identifier ?? ""))
                } label: {
                    Text("Price")
                }
                LabeledContent("Fizzy?", value: drink.isFizzy ? "✅" : "❌")
            }
            
            Section("Description") {
                Text(drink.description)
            }
            
            if drink.allergies?.isEmpty == false ||
                drink.ingredients?.isEmpty == false {
                
                Section("Dietry") {
                    
                    if let ingredients = drink.ingredients {
                        NavigationLink(value: Route.ingredients(items: ingredients)) {
                            let countVw = Text("x\(ingredients.count)").font(.footnote).bold()
                            Text("\(countVw) Ingredients")
                        }
                    }
                    
                    if let allergies = drink.allergies {
                        NavigationLink(value: Route.allergies(items: allergies)) {
                            let countVw = Text("x\(allergies.count)").font(.footnote).bold()
                            Text("\(countVw) Allergies")
                        }
                    }
                }
            }
            
            if let locations = drink.locations {
                
                Section("Locations") {
                    
                    Button("See all locations") {
                        routerManager.push(to: .locations(places: locations))
                    }
                }
            }

            
            Section {
                Button {
                    cartManager.add(drink)
                    routerManager.reset()
                } label: {
                    Label("Add to cart", systemImage: "cart")
                        .symbolVariant(.fill)
                }
            }

        }
        .navigationTitle(drink.title)
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DrinkDetailView(drink: drinks[0])
                .environmentObject(ShoppingCartManager())
                .environment(NavigationRouter())
        }
    }
}
