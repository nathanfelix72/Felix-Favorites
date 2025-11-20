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
    
    // MARK: - Initialization
    
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Model Access
    
    var recipeCategories: [Category] {
        let descriptor = FetchDescriptor<Category>(sortBy: [SortDescriptor(\Category.name)])
        
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
    var recipes: [Recipe] {
        let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\Recipe.name)])
        
        return (try? modelContext.fetch(descriptor)) ?? []
    }
    
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
    
    // MARK: - User Intents
    
    // create recipe
    // update recipe
    // ...
    
    func delete(_ recipe: Recipe) {
        if selectedRecipe == recipe {
            selectedRecipe = nil
        }
        
        modelContext.delete(recipe)
    }
    
    func removeRecipes(at indexSet: IndexSet) {
        for index in indexSet {
            let recipeToDelete = recipes[index]
            if selectedRecipe?.persistentModelID == recipeToDelete.persistentModelID {
                selectedRecipe = nil
            }
            modelContext.delete(recipeToDelete)
        }
    }
    
    func ensureSomeDataExists() {
        if recipeCategories.isEmpty {
            Category.insertSampleData(modelContext: modelContext)
        }
    }
    
    func reloadSampleData() {
        selectedRecipe = nil
        selectedCategoryName = nil
        Category.reloadSampleData(modelContext: modelContext)
    }
    
    // MARK: - Helpers
    
    func update() {
        // TODO
    }
}
