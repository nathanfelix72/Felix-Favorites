//
//  RecipeDetailContentView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/2/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI

struct RecipeDetailContentView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    let recipe: Recipe

    var body: some View {
        List {
            Section("General") {
                Section("Categories") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recipeViewModel.recipeCategories, id: \.name) { category in
                                Button {
                                    // TODO: handle category tap
                                } label: {
                                    Text(category.name)
                                        .font(.caption)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 10)
                                        .background(recipe.categories.contains(where: { $0.name == category.name }) ? Color.accentColor.opacity(0.2) : Color.secondary.opacity(0.1))
                                        .clipShape(Capsule())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 4)
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
                    Text("\(recipe.timeRequired) minutes")
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

                HStack {
                    Text("Favorite")
                    Spacer()
                    Image(systemName: recipe.isFavorite ? "star.fill" : "star")
                        .foregroundColor(recipe.isFavorite ? .yellow : .gray)
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

//#Preview {
//    RecipeDetailContentView()
//}
