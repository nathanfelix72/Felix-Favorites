//
// RecipeListView.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct RecipeListView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        if let recipeCategoryName = recipeViewModel.selectedCategoryName {
            RecipeList(recipeCategoryName: recipeCategoryName)
        } else {
            ContentUnavailableView("Select a category", systemImage: "sidebar.left")
        }
    }
}

private struct RecipeList: View {
    let recipeCategoryName: String
    
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    @State private var isEditorPresented = false
    
    // Filter recipes by the selected category
    private var filteredRecipes: [Recipe] {
        let filtered = recipeViewModel.recipes.filter { recipe in
            let hasCategory = recipe.categories.contains { category in
                category.name == recipeCategoryName
            }
            print("Recipe: \(recipe.name), Categories: \(recipe.categories.map { $0.name }), Looking for: \(recipeCategoryName), Has it: \(hasCategory)")
            return hasCategory
        }
        print("Total recipes: \(recipeViewModel.recipes.count), Filtered: \(filtered.count)")
        return filtered
    }
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        List(selection: $recipeViewModel.selectedRecipe) {
            ForEach(filteredRecipes) { recipe in
                NavigationLink(recipe.name, value: recipe)
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

//#Preview("RecipeListView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            RecipeListView(recipeCategoryName: Category.mammal.name)
//                .environment(RecipeViewModel())
//        }
//    }
//}
//
//#Preview("No selected category") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeListView(recipeCategoryName: nil)
//    }
//}
//
//#Preview("No recipies") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeList(recipeCategoryName: Category.fish.name)
//            .environment(RecipeViewModel())
//    }
//}
//
//#Preview("AddRecipeButton") {
//    AddRecipeButton(isActive: .constant(false))
//}
