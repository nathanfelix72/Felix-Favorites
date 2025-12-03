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
        let filtered = recipeViewModel.recipes.filter { recipe in
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
                    RecipeRow(recipe: recipe)
                }
            }
            .onDelete(perform: removeRecipes)
        }
        .sheet(isPresented: $isEditorPresented) {
            RecipeEditor(recipe: nil)
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
    }
    
    private func removeRecipes(at indexSet: IndexSet) {
        recipeViewModel.removeRecipes(at: indexSet)
    }
}

private struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(recipe.name)
                .font(.headline)
            
            HStack {
                if recipe.timeRequired > 0 {
                    Label("\(recipe.timeRequired) min", systemImage: "clock")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if recipe.servings > 0 {
                    Label("\(recipe.servings) servings", systemImage: "person.2")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if recipe.isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            
            if !recipe.notes.isEmpty {
                Text(recipe.notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct AddRecipeButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a recipe", systemImage: "plus")
                .help("Add a recipe")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
