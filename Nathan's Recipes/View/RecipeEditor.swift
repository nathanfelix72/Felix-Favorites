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
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.name) private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $selectedCategory) {
                    Text("Select a category").tag(nil as Category?)
                    ForEach(categories) { category in
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
            recipe.name = name
            recipe.diet = selectedDiet
            recipe.category = selectedCategory
        } else {
            // Add a recipe.
            let newRecipe = Recipe(name: name, diet: selectedDiet)
            newRecipe.category = selectedCategory
            modelContext.insert(newRecipe)
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
