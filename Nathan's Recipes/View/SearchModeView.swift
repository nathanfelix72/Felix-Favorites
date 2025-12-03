//
//  SearchModeView.swift
//  Nathan's Recipes
//
//  Created by IS 543 on 12/3/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import SwiftUI
import SwiftData

struct SearchModeView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isReloadPresented = false

    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        
        List(selection: $recipeViewModel.selectedCategoryNames) {
            Section("Search By:") {
                NavigationLink(destination: FavoriteRecipesView()) {
                    Label(SearchMode.byFavorites.rawValue, systemImage: SearchMode.byFavorites.icon)
                }
                
                NavigationLink(destination: AllRecipesView()) {
                    Label(SearchMode.allRecipes.rawValue, systemImage: SearchMode.allRecipes.icon)
                }
            }
            
            Section("Categories") {
                CategoryList(recipeCategories: recipeViewModel.recipeCategories)
            }
        }
        .navigationTitle("Search")
        .alert("Reload Sample Data?", isPresented: $isReloadPresented) {
            Button("Yes, reload sample data", role: .destructive) {
                recipeViewModel.reloadSampleData()
            }
        } message: {
            Text("Reloading the sample data deletes all changes to the current data.")
        }
        .toolbar {
            Button {
                isReloadPresented = true
            } label: {
                Label("", systemImage: "arrow.clockwise")
                    .help("Reload sample data")
            }
        }
        .task {
            recipeViewModel.ensureSomeDataExists()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
