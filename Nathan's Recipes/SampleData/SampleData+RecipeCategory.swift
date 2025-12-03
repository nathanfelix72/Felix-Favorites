//
// SampleData+RecipeCategory.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import Foundation
import SwiftData

extension Category {
    static let italian = Category(name: "Italian")
    static let american = Category(name: "American")
    static let french = Category(name: "French")
    static let mexican = Category(name: "Mexican")
    static let asian = Category(name: "Asian")
    static let mediterranean = Category(name: "Mediterranean")
    static let breakfast = Category(name: "Breakfast")

    static func insertSampleData(modelContext: ModelContext) {
        // Add the recipe categories to the model context.
        modelContext.insert(italian)
        modelContext.insert(american)
        modelContext.insert(french)
        modelContext.insert(mexican)
        modelContext.insert(asian)
        modelContext.insert(mediterranean)
        modelContext.insert(breakfast)
        
        // Add the recipes to the model context.
        modelContext.insert(Recipe.snickerdoodles)
        modelContext.insert(Recipe.sachertorte)
        modelContext.insert(Recipe.pretzels)
        modelContext.insert(Recipe.caesarSalad)
        modelContext.insert(Recipe.chickenParm)
        modelContext.insert(Recipe.pancakes)
        
        // Set the category for each recipe.
        Recipe.snickerdoodles.categories.append(american)
        Recipe.sachertorte.categories.append(french)
        Recipe.pretzels.categories.append(american)
        Recipe.caesarSalad.categories.append(italian)
        Recipe.chickenParm.categories.append(italian)
        Recipe.pancakes.categories.append(american)
        Recipe.pancakes.categories.append(breakfast)
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Category.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
