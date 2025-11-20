//
// ContentView.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct ContentView: View {
    @SwiftDataViewModel private var recipeViewModel: RecipeViewModel

    var body: some View {
        ThreeColumnContentView()
            .environment(recipeViewModel)
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
