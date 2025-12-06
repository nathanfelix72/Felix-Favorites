//
//  ContentListView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/3/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct ContentListView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        
        Group {
            if let categoryName = recipeViewModel.selectedCategoryNames {
                RecipeList(recipeCategoryName: categoryName)
            } else {
                ContentUnavailableView("Select a category or search option", systemImage: "sidebar.left")
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
