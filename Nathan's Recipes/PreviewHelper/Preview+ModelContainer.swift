//
// Preview+ModelContainer.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Category.self, Recipe.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        MainActor.assumeIsolated {
            Category.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
