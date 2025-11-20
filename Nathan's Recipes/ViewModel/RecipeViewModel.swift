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
    private var modelContext: ModelContext
    
    var selectedCategoryName: String?
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility = .automatic
    
    var sidebarTitle = "Categories"
    
    required init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func update() {
        // TODO
    }
    
    var contentListTitle: String {
        if let selectedCategoryName {
            selectedCategoryName
        } else {
            ""
        }
    }
    
//    init(selectedCategoryName: String? = nil,
//         selectedRecipe: Recipe? = nil,
//         columnVisibility: NavigationSplitViewVisibility = .automatic) {
//        self.selectedCategoryName = selectedCategoryName
//        self.selectedRecipe = selectedRecipe
//        self.columnVisibility = columnVisibility
//    }
}
