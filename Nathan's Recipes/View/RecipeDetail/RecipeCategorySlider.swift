//
//  RecipeCategorySlider.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/2/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct RecipeCategorySlider: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    let recipe: Recipe
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(recipeViewModel.recipeCategories, id: \.name) { category in
                    Button {
                        recipeViewModel.toggleCategory(category, recipe)
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
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
