//
// RecipeDetailView.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    
    // MARK: - Properites
    
    @State private var isEditing = false
    @State private var isDeleting = false
    
    @Environment(RecipeViewModel.self) private var recipeViewModel

    var body: some View {
        if let recipe = recipeViewModel.selectedRecipe {
            RecipeDetailContentView(recipe: recipe)
                .navigationTitle("\(recipe.name)")
                .toolbar {
                    Button { isEditing = true } label: {
                        Label("Edit \(recipe.name)", systemImage: "pencil")
                            .help("Edit the recipe")
                    }
                    
                    Button { isDeleting = true } label: {
                        Label("Delete \(recipe.name)", systemImage: "trash")
                            .help("Delete the recipe")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    RecipeEditor(recipe: recipe)
                }
                .alert("Delete \(recipe.name)?", isPresented: $isDeleting) {
                    Button("Yes, delete \(recipe.name)", role: .destructive) {
                        delete(recipe)
                    }
                }
        } else {
            ContentUnavailableView("Select a recipe", systemImage: Default.imageName)
        }
    }
    
    private func delete(_ recipe: Recipe) {
        recipeViewModel.delete(recipe)
    }
}

private struct RecipeDetailContentView: View {
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    let recipe: Recipe

    var body: some View {
        VStack {

            EmptyView()
            
            List {
                HStack {
                    Text("Category")
                    Spacer()
                    Text("\(recipeViewModel.categoryText(for: recipe))")
                }
                HStack {
                    Text("Author")
                    Spacer()
                    Text("\(recipe.author)")
                }
            }
        }
    }
}

//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        RecipeDetailView(recipe: .pretzels)
//            .environment(RecipeViewModel())
//    }
//}
