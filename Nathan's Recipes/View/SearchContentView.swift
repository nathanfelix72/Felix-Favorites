//
//  SearchContentView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/3/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct SearchContentView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        if let searchMode = recipeViewModel.selectedSearchMode {
            switch searchMode {
            case .byCategory:
                RecipeCategoryListView()
            case .byFavorites:
                FavoriteRecipesView()
            case .allRecipes:
                AllRecipesView()
            }
        } else {
            ContentUnavailableView("Select a search mode", systemImage: "sidebar.left")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
