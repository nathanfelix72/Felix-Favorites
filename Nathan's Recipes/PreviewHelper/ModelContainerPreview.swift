//
// ModelContainerPreview.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import SwiftUI
import SwiftData

struct ModelContainerPreview<Content: View>: View {
    var content: () -> Content
    let container: ModelContainer

    /// Creates an instance of the model container preview.
    ///
    /// This view creates the model container before displaying the preview
    /// content. The view is intended for use in previews only.
    ///
    ///     #Preview {
    ///         ModelContainerPreview {
    ///             RecipeEditor(recipe: nil)
    ///                 .environment(RecipeViewModel())
    ///             } modelContainer: {
    ///                 let schema = Schema([Category.self, Recipe.self])
    ///                 let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    ///                 let container = try ModelContainer(for: schema, configurations: [configuration])
    ///                 Task { @MainActor in
    ///                     Category.insertSampleData(modelContext: container.mainContext)
    ///                 }
    ///             return container
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - content: A view that describes the content to preview.
    ///   - modelContainer: A closure that returns a model container.
    init(@ViewBuilder content: @escaping () -> Content, modelContainer: @escaping () throws -> ModelContainer) {
        self.content = content
        do {
            self.container = try MainActor.assumeIsolated(modelContainer)
        } catch {
            fatalError("Failed to create the model container: \(error.localizedDescription)")
        }
    }

    /// Creates a view that creates the provided model container before displaying
    /// the preview content.
    ///
    /// This view creates the model container before displaying the preview
    /// content. The view is intended for use in previews only.
    ///
    ///     #Preview {
    ///         ModelContainerPreview(SampleModelContainer.main) {
    ///             RecipeEditor(recipe: .pretzels)
    ///                 .environment(RecipeViewModel())
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - modelContainer: A closure that returns a model container.
    ///   - content: A view that describes the content to preview.
    init(_ modelContainer: @escaping () throws -> ModelContainer, @ViewBuilder content: @escaping () -> Content) {
        self.init(content: content, modelContainer: modelContainer)
    }

    var body: some View {
        content()
            .modelContainer(container)
    }
}
