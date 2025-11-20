//
// RecipeEditor.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct RecipeEditor: View {
    let recipe: Recipe?
    
    private var editorTitle: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    @State private var name = ""
    @State private var selectedDiet = Recipe.Diet.breakfast
    @State private var selectedCategory: Category?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $selectedCategory) {
                    Text("Select a category").tag(nil as Category?)
                    ForEach(recipeViewModel.recipeCategories) { category in
                        Text(category.name).tag(category as Category?)
                    }
                }
                
                Picker("Diet", selection: $selectedDiet) {
                    ForEach(Recipe.Diet.allCases, id: \.self) { diet in
                        Text(diet.rawValue).tag(diet)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a category to save changes.
                    .disabled($selectedCategory.wrappedValue == nil)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let recipe {
                    // Edit the incoming recipe.
                    name = recipe.name
                    selectedDiet = recipe.diet
                    selectedCategory = recipe.category
                }
            }
        }
    }
    
    private func save() {
        if let recipe {
            // Edit the recipe.
            recipeViewModel.updateRecipe(recipe, name: name, diet: selectedDiet, category: selectedCategory)
        } else {
            // Add a recipe.
            recipeViewModel.createRecipe(name: name, diet: selectedDiet, category: selectedCategory)
        }
    }
}

//#Preview("Add recipe") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeEditor(recipe: nil)
//    }
//}
//
//#Preview("Edit recipe") {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeEditor(recipe: .pretzels)
//    }
//}
