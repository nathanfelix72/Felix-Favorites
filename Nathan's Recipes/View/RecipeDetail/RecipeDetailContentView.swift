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
    let recipe: Recipe

    var body: some View {
        List {
            Section("Categories") {
                RecipeCategorySlider(recipe: recipe)
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
                    Text("Calories")
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
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
