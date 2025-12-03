//
// RecipeViewModel.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
//

import SwiftUI
import SwiftData

@Observable
class RecipeViewModel: ContextReferencing {
    
    // MARK: - Properties
    
    private var modelContext: ModelContext
    
    var selectedCategoryName: String?
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility = .automatic
    
    var sidebarTitle = "Categories"
    
    // Cached data
    var recipeCategories: [Category] = []
    var recipes: [Recipe] = []
    
    // MARK: - Initialization
    
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
        update()
    }
    
    // MARK: - Model Access
    
    // read all recipes
    // read favorites
    // read a category's recipes
    // ...
    
    var contentListTitle: String {
        if let selectedCategoryName {
            selectedCategoryName
        } else {
            ""
        }
    }
    
    func categoryText(for recipe: Recipe) -> String {
        recipe.categories.compactMap(\.name).joined(separator: ", ")
    }
    
    // MARK: - User Intents
    
    func createRecipe(name: String, category: Category?) {
        let newRecipe = Recipe(name: name)
        // Assign the selected category to the recipe's categories array (supporting multiple categories).
        newRecipe.categories = category.map { [$0] } ?? []
        modelContext.insert(newRecipe)
        update()
    }
    
    func updateRecipe(_ recipe: Recipe, name: String, category: Category?) {
        recipe.name = name
        // Replace the recipe's categories with the provided selection (UI currently supports one selection).
        recipe.categories = category.map { [$0] } ?? []
        update()
    }
    
    func delete(_ recipe: Recipe) {
        if selectedRecipe == recipe {
            selectedRecipe = nil
        }
        
        modelContext.delete(recipe)
        update()
    }
    
    func removeRecipes(at indexSet: IndexSet) {
        for index in indexSet {
            let recipeToDelete = recipes[index]
            if selectedRecipe?.persistentModelID == recipeToDelete.persistentModelID {
                selectedRecipe = nil
            }
            modelContext.delete(recipeToDelete)
        }
        update()
    }
    
    func ensureSomeDataExists() {
        if recipeCategories.isEmpty {
            Category.insertSampleData(modelContext: modelContext)
            update()
        }
    }
    
    func reloadSampleData() {
        selectedRecipe = nil
        selectedCategoryName = nil
        Category.reloadSampleData(modelContext: modelContext)
        update()
    }
    
    // MARK: - Helpers
    
    func update() {
        let categoryDescriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\Category.name)])
        recipeCategories = (try? modelContext.fetch(categoryDescriptor)) ?? []
        
        let recipeDescriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\Recipe.name)])
        recipes = (try? modelContext.fetch(recipeDescriptor)) ?? []
    }
}
