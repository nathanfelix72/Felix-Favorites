//
//  FavoriteRecipesView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/3/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct FavoriteRecipesView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isEditorPresented = false
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(recipeViewModel.favoriteRecipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeListRow(recipe: recipe)
                }
            }
        }
        .navigationTitle("Favorite Recipes")
        .overlay {
            if recipeViewModel.favoriteRecipes.isEmpty {
                ContentUnavailableView {
                    Label("No favorite recipes yet", systemImage: "heart.slash")
                } description: {
                    Text("Mark recipes as favorites to see them here")
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
