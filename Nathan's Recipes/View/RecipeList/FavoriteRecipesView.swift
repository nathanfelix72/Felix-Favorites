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
            ForEach(recipeViewModel.filteredFavoriteRecipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeListRow(recipe: recipe)
                }
            }
        }
        .navigationTitle("Favorite Recipes")
        .searchable(text: $recipeViewModel.searchText, prompt: "Search")
        .onAppear {
            recipeViewModel.searchText = ""
        }
        .overlay {
            if recipeViewModel.filteredFavoriteRecipes.isEmpty {
                ContentUnavailableView {
                    Label(recipeViewModel.searchText.isEmpty ? "No recipes" : "No favorite recipes with this search", systemImage: "heart.slash")
                } description: {
                    Text(recipeViewModel.searchText.isEmpty ? "Add some recipes to your favorites" : "No recipes with this search")
                }
            }
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
