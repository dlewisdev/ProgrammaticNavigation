//
//  FoodDetailView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 03/02/2023.
//

import SwiftUI

struct FoodDetailView: View {
    
    @EnvironmentObject private var cartManager: ShoppingCartManager
    @Environment(NavigationRouter.self) private var routerManager: NavigationRouter

    let food: Food
    
    var body: some View {
        List {
            
            Section {
                LabeledContent("Icon", value: food.name)
                LabeledContent("Name", value: food.title)
                LabeledContent {
                    Text(food.price,
                         format: .currency(code: Locale.current.currency?.identifier ?? ""))
                } label: {
                    Text("Price")
                }
            }
            
            Section("Description") {
                Text(food.description)
            }
            
            if food.allergies?.isEmpty == false ||
               food.ingredients?.isEmpty == false {
                
                Section("Dietary") {
                    
                    if let ingredients = food.ingredients {
                        NavigationLink(value: Route.ingredients(items: ingredients)) {
                            let countVw = Text("x\(ingredients.count)").font(.footnote).bold()
                            Text("\(countVw) Ingredients")
                        }
                    }
                    
                    if let allergiesCount = food.allergies?.count {
                        let countVw = Text("x\(allergiesCount)").font(.footnote).bold()
                        Text("\(countVw) Allergies")
                    }
                }
            }
            
            if food.locations?.isEmpty == false {
                
                Section("Locations") {
                    
                    if let locationsCount = food.locations?.count {
                        let countVw = Text("x\(locationsCount)").font(.footnote).bold()
                        Text("\(countVw) Locations")
                    }
                }
            }

            Section {
                Button {
                    cartManager.add(food)
                    routerManager.reset()
                } label: {
                    Label("Add to cart", systemImage: "cart")
                        .symbolVariant(.fill)
                }
            }

        }
        .navigationTitle(food.title)
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FoodDetailView(food: foods[0])
                .environmentObject(ShoppingCartManager())
                .environment(NavigationRouter())
        }
    }
}
