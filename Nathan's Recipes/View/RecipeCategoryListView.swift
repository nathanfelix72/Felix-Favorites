//
// RecipeCategoryListView.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct RecipeCategoryListView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    @State private var isReloadPresented = false

    var body: some View {
        @Bindable var recipeViewModel = recipeViewModel
        List(selection: $recipeViewModel.selectedCategoryName) {
            ListCategories(recipeCategories: recipeViewModel.recipeCategories)
        }
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

private struct ListCategories: View {
    var recipeCategories: [Category]
    
    var body: some View {
        ForEach(recipeCategories) { recipeCategory in
            NavigationLink(recipeCategory.name, value: recipeCategory.name)
        }
    }
}

//#Preview("RecipeCategoryListView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            RecipeCategoryListView()
//        }
//        .environment(RecipeViewModel())
//    }
//}
//
//#Preview("ListCategories") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            List {
//                ListCategories(recipeCategories: [.amphibian, .bird])
//            }
//        }
//        .environment(RecipeViewModel())
//    }
//}
