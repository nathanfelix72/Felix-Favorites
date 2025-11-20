//
// ThreeColumnContentView.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct ThreeColumnContentView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        NavigationSplitView(columnVisibility: $recipeViewModel.columnVisibility) {
            RecipeCategoryListView()
                .navigationTitle(recipeViewModel.sidebarTitle)
        } content: {
            RecipeListView(recipeCategoryName: recipeViewModel.selectedCategoryName)
                .navigationTitle(recipeViewModel.contentListTitle)
        } detail: {
            NavigationStack {
                RecipeDetailView()
            }
        }
    }
}

//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        ThreeColumnContentView()
//            .environment(RecipeViewModel())
//    }
//}
