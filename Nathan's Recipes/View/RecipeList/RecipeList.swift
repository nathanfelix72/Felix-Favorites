//
//  RecipeList.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/2/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct RecipeList: View {
    let recipeCategoryName: String
    
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isEditorPresented = false
    
    // Filter recipes by the selected category
    private var filteredRecipes: [Recipe] {
        let filtered = recipeViewModel.filteredRecipes.filter { recipe in
            let hasCategory = recipe.categories.contains { category in
                category.name == recipeCategoryName
            }
            return hasCategory
        }
        return filtered
    }
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(filteredRecipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeListRow(recipe: recipe)
                }
            }
            .onDelete(perform: removeRecipes)
        }
        .sheet(isPresented: $isEditorPresented) {
            RecipeEditor(recipe: nil)
        }
        .onAppear {
            recipeViewModel.searchText = ""
        }
        .overlay {
            if filteredRecipes.isEmpty {
                ContentUnavailableView {
                    Label("No recipes in this category", systemImage: Default.imageName)
                } description: {
                    AddRecipeButton(isActive: $isEditorPresented)
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
        recipeViewModel.removeRecipes(at: indexSet)
    }
}

#Preview {
    let container = try! ModelContainer.sample()
    let recipeViewModel = RecipeViewModel(modelContext: container.mainContext)
    
    return ThreeColumnContentView()
        .modelContainer(container)
        .environment(recipeViewModel)
}
