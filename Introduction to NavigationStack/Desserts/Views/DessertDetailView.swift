//
//  DessertDetailView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 04/02/2023.
//

import SwiftUI

struct DessertDetailView: View {
    @Environment(NavigationRouter.self) private var routerManager: NavigationRouter
    @EnvironmentObject private var cartManager: ShoppingCartManager
    let dessert: Dessert
    
    var body: some View {
        List {
            
            Section {
                LabeledContent("Icon", value: dessert.name)
                LabeledContent("Name", value: dessert.title)
                LabeledContent {
                    Text(dessert.price,
                         format: .currency(code: Locale.current.currency?.identifier ?? ""))
                } label: {
                    Text("Price")
                }
                LabeledContent("Cold?", value: dessert.isCold ? "✅" : "❌")
            }
            
            Section("Description") {
                Text(dessert.description)
            }
            
            if dessert.allergies?.isEmpty == false ||
                dessert.ingredients?.isEmpty == false {
                
                Section("Dietry") {
                    
                    if let ingredients = dessert.ingredients {
                        NavigationLink(value: Route.ingredients(items: ingredients)) {
                            let countVw = Text("x\(ingredients.count)").font(.footnote).bold()
                            Text("\(countVw) Ingredients")
                        }
                    }
                    
                    if let allergies = dessert.allergies {
                        NavigationLink(value: Route.allergies(items: allergies)) {
                            let countVw = Text("x\(allergies.count)").font(.footnote).bold()
                            Text("\(countVw) Allergies")
                        }
                    }
                }
            }
            
            if let locations = dessert.locations {
                
                Section("Locations") {
                    
                    Button("See all locations") {
                        routerManager.push(to: .locations(places: locations))
                    }
                }
            }

            
            Section {
                Button {
                    cartManager.add(dessert)
                    routerManager.reset()
                } label: {
                    Label("Add to cart", systemImage: "cart")
                        .symbolVariant(.fill)
                }
            }

        }
        .navigationTitle(dessert.title)
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            
            DessertDetailView(dessert: desserts[0])
                .environmentObject(ShoppingCartManager())
                .environment(NavigationRouter())
        }
    }
}
