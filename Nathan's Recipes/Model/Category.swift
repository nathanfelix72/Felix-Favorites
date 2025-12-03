//
// Category.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .nullify, inverse: \Recipe.categories)
    var recipes = [Recipe]()
    
    init(name: String) {
        self.name = name
    }
}
