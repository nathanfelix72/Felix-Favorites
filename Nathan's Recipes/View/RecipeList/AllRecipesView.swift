//
//  AllRecipesView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/3/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct AllRecipesView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isEditorPresented = false
    
    let searchText: String
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(recipeViewModel.filteredRecipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeListRow(recipe: recipe)
                }
            }
            .onDelete(perform: removeRecipes)
        }
        .navigationTitle("All Recipes")
        .sheet(isPresented: $isEditorPresented) {
            RecipeEditor(recipe: nil)
        }
        .onAppear {
            recipeViewModel.searchText = ""
        }
        .overlay {
            if searchResults.isEmpty {
                ContentUnavailableView {
                    Label("No recipes", systemImage: Default.imageName)
                } description: {
                    Text(searchText.isEmpty ? "New recipes you create will appear here." : "No recipes match your search.")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddRecipeButton(isActive: $isEditorPresented)
            }
        }
        .searchable(text: $recipeViewModel.searchText, prompt: "Search")
    }
    
    private func removeRecipes(at indexSet: IndexSet) {
        // Convert indexSet to indices in the filtered searchResults
        let recipesToDelete = indexSet.map { searchResults[$0] }
        
        // Delete each recipe from the view model
        for recipe in recipesToDelete {
            if let index = recipeViewModel.recipes.firstIndex(where: { $0.id == recipe.id }) {
                recipeViewModel.removeRecipes(at: IndexSet(integer: index))
            }
        }
    }
    
    private var searchResults: [Recipe] {
        if searchText.isEmpty {
            recipeViewModel.recipes
        } else {
            recipeViewModel.recipes.filter { recipe in
                recipe.asSearchString.contains(searchText.lowercased())
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
