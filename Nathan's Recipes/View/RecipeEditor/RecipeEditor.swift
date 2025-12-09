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
    // Keep a set of selected category names to support multi-selection.
    @State private var selectedCategoryNames: Set<String> = []
    
    // New state for all editable fields
    @State private var author = ""
    @State private var date = Date()
    @State private var minutes: Int = 20
    @State private var servings: Int = 1
    @State private var expertiseLevel = "Easy"
    @State private var calories: Int = 100
    @State private var isFavorite: Bool = false
    @State private var notes = ""
    @State private var ingredients = ""
    @State private var instructions = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var recipeViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    TextField("Name", text: $name)
                    TextField("Author", text: $author)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    HStack {
                        Stepper(value: $minutes, in: 0...1000) {
                            Text("Minutes: \(minutes)")
                        }
                    }
                    HStack {
                        Stepper(value: $servings, in: 1...50) {
                            Text("Servings: \(servings)")
                        }
                    }
                    Picker("Expertise", selection: $expertiseLevel) {
                        Text("Easy").tag("Easy")
                        Text("Medium").tag("Medium")
                        Text("Hard").tag("Hard")
                    }
                    HStack {
                        Stepper(value: $calories, in: 0...10000, step: 10) {
                            Text("Calories per serving: \(calories)")
                        }
                    }
                    Toggle("Favorite", isOn: $isFavorite)
                }
                
                Section("Categories") {
                    ForEach(recipeViewModel.recipeCategories, id: \.name) { category in
                        Toggle(isOn: Binding(get: {
                            selectedCategoryNames.contains(category.name)
                        }, set: { isOn in
                            if isOn {
                                selectedCategoryNames.insert(category.name)
                            } else {
                                selectedCategoryNames.remove(category.name)
                            }
                        })) {
                            Text(category.name)
                        }
                    }
                }
                
                Section("Ingredients") {
                    TextEditor(text: $ingredients)
                        .frame(minHeight: 100)
                }
                
                Section("Instructions") {
                    TextEditor(text: $instructions)
                        .frame(minHeight: 150)
                }
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
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
                    .disabled(name.isEmpty)
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
                    author = recipe.author
                    date = recipe.date
                    minutes = recipe.minutes
                    servings = recipe.servings
                    expertiseLevel = recipe.expertiseLevel
                    calories = recipe.calories
                    isFavorite = recipe.isFavorite
                    notes = recipe.notes
                    ingredients = recipe.ingredients
                    instructions = recipe.instructions
                    selectedCategoryNames = Set(recipe.categories.map { $0.name })
                } else {
                    // Ensure category list is available for selection when creating.
                    recipeViewModel.ensureSomeDataExists()
                }
            }
        }
    }
    
    private func save() {
        let selected = recipeViewModel.recipeCategories.filter { selectedCategoryNames.contains($0.name) }
        if let recipe {
            // Update existing recipe with all fields
            recipeViewModel.updateRecipe(
                recipe,
                name: name,
                author: author,
                date: date,
                minutes: minutes,
                servings: servings,
                expertiseLevel: expertiseLevel,
                calories: calories,
                isFavorite: isFavorite,
                notes: notes,
                ingredients: ingredients,
                instructions: instructions,
                categories: selected
            )
        } else {
            // Create new recipe with all fields
            recipeViewModel.createRecipe(
                name: name,
                author: author,
                date: date,
                minutes: minutes,
                servings: servings,
                expertiseLevel: expertiseLevel,
                calories: calories,
                isFavorite: isFavorite,
                notes: notes,
                ingredients: ingredients,
                instructions: instructions,
                categories: selected
            )
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
