//
//  RecipeDetailContentView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/2/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct RecipeDetailContentView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    @State private var isAddCategoryPresented = false
    let recipe: Recipe

    var body: some View {
        List {
            Section {
                CategorySlider(recipe: recipe)
            } header: {
                HStack {
                    Text("Categories")
                    Spacer()
                    Button {
                        isAddCategoryPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderless)
                    .help("Add new category")
                }
            }
            
            Section("General") {
                HStack {
                    Text("Favorite")
                    Spacer()
                    Button {
                        recipeViewModel.toggleFavorite(recipe)
                    } label: {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(recipe.isFavorite ? .red : .gray)
                    }
                }
                
                HStack {
                    Text("Author")
                    Spacer()
                    Text(recipe.author)
                }

                HStack {
                    Text("Preparation Time")
                    Spacer()
                    Text("\(recipe.minutes) minutes")
                }

                HStack {
                    Text("Servings")
                    Spacer()
                    Text("\(recipe.servings)")
                }

                HStack {
                    Text("Expertise")
                    Spacer()
                    Text(recipe.expertiseLevel)
                }

                HStack {
                    Text("Calories per Serving")
                    Spacer()
                    Text("\(recipe.calories)")
                }
            }

            Section("Ingredients") {
                Text(recipe.ingredients)
            }

            Section("Instructions") {
                Text(recipe.instructions)
            }

            Section("Notes") {
                Text(recipe.notes)
            }
        }
        .listStyle(.insetGrouped)
        .sheet(isPresented: $isAddCategoryPresented) {
            CategoryEditor(category: nil)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    let container = try! ModelContainer.sample()
    let recipeViewModel = RecipeViewModel(modelContext: container.mainContext)
    
    return ThreeColumnContentView()
        .modelContainer(container)
        .environment(recipeViewModel)
}
