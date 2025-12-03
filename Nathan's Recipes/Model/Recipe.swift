//
// Recipe.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import Foundation
import SwiftData

@Model
final class Recipe {
    var name: String
    var author: String = "Unknown"
    var date: Date = Date()
    var timeRequired: Int = 0
    var servings: Int = 1
    var expertiseLevel: String = "Easy"
    var calories: Int = 0
    var isFavorite: Bool = false
    var notes: String = ""
    var ingredients: String = ""
    var instructions: String = ""
    var categories: [Category] = []
    
    init(name: String) {
        self.name = name
    }
}
