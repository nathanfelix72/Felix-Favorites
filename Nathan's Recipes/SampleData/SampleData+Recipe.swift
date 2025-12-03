//
// SampleData+Recipe.swift
// Felix Nathan Project 2
//
// Created by Nathan Felix on 11/13/25
// 

import Foundation

extension Recipe {
    static let snickerdoodles: Recipe = {
        let recipe = Recipe(name: "Snickerdoodles")
        recipe.author = "Grandma Betty"
        recipe.timeRequired = 25
        recipe.servings = 24
        recipe.expertiseLevel = "Easy"
        recipe.calories = 120
        recipe.notes = "Classic cinnamon sugar cookies with a soft, chewy center"
        recipe.ingredients = "1 cup butter, softened\n1½ cups sugar\n2 eggs\n2¾ cups flour\n2 tsp cream of tartar\n1 tsp baking soda\n¼ tsp salt\n3 tbsp sugar\n3 tsp cinnamon"
        recipe.instructions = "1. Preheat oven to 350°F\n2. Cream butter and 1½ cups sugar\n3. Beat in eggs\n4. Mix dry ingredients and combine\n5. Roll into balls, coat with cinnamon-sugar\n6. Bake 10-12 minutes"
        return recipe
    }()
    
    static let sachertorte: Recipe = {
        let recipe = Recipe(name: "Sachertorte")
        recipe.author = "Chef Marcel"
        recipe.timeRequired = 120
        recipe.servings = 12
        recipe.expertiseLevel = "Hard"
        recipe.calories = 380
        recipe.isFavorite = true
        recipe.notes = "Legendary Viennese chocolate cake with apricot jam and chocolate glaze"
        recipe.ingredients = "6 oz dark chocolate\n¾ cup butter\n¾ cup sugar\n6 eggs, separated\n1 cup flour\n½ cup apricot jam\nChocolate glaze"
        recipe.instructions = "1. Melt chocolate and butter\n2. Beat egg yolks with half the sugar\n3. Whip egg whites with remaining sugar to stiff peaks\n4. Fold everything together with flour\n5. Bake at 350°F for 45 minutes\n6. Split, fill with jam, glaze with chocolate"
        return recipe
    }()
    
    static let pretzels: Recipe = {
        let recipe = Recipe(name: "Bavarian Soft Pretzels")
        recipe.author = "Hans Mueller"
        recipe.timeRequired = 90
        recipe.servings = 8
        recipe.expertiseLevel = "Medium"
        recipe.calories = 280
        recipe.notes = "Authentic German pretzels with a distinctive golden brown crust"
        recipe.ingredients = "1½ cups warm water\n1 tbsp sugar\n2 tsp salt\n1 package active dry yeast\n4½ cups flour\n4 tbsp butter, melted\n⅔ cup baking soda\nCoarse salt"
        recipe.instructions = "1. Dissolve yeast in warm water with sugar\n2. Mix in flour, salt, and butter to form dough\n3. Let rise 1 hour\n4. Shape into pretzel twists\n5. Boil in baking soda water 30 seconds each\n6. Bake at 450°F for 12-15 minutes"
        return recipe
    }()
    
    static let caesarSalad: Recipe = {
        let recipe = Recipe(name: "Caesar Salad")
        recipe.author = "Chef Antonio"
        recipe.timeRequired = 15
        recipe.servings = 4
        recipe.expertiseLevel = "Easy"
        recipe.calories = 320
        recipe.isFavorite = true
        recipe.notes = "Classic Caesar with homemade dressing and garlic croutons"
        recipe.ingredients = "1 large romaine lettuce\n½ cup olive oil\n2 cloves garlic\n3 anchovy fillets\n1 egg yolk\n2 tbsp lemon juice\n½ cup Parmesan\nCroutons"
        recipe.instructions = "1. Chop romaine lettuce\n2. Blend garlic, anchovies, egg yolk, lemon juice\n3. Slowly drizzle in olive oil while blending\n4. Toss lettuce with dressing\n5. Top with Parmesan and croutons"
        return recipe
    }()
    
    static let chickenParm: Recipe = {
        let recipe = Recipe(name: "Chicken Parmesan")
        recipe.author = "Nonna Rosa"
        recipe.timeRequired = 45
        recipe.servings = 4
        recipe.expertiseLevel = "Medium"
        recipe.calories = 520
        recipe.notes = "Crispy breaded chicken topped with marinara and melted mozzarella"
        recipe.ingredients = "4 chicken breasts\n1 cup flour\n2 eggs, beaten\n2 cups breadcrumbs\n2 cups marinara sauce\n2 cups mozzarella, shredded\n½ cup Parmesan\nFresh basil"
        recipe.instructions = "1. Pound chicken to even thickness\n2. Dredge in flour, egg, then breadcrumbs\n3. Pan-fry until golden brown\n4. Place in baking dish, top with marinara and cheese\n5. Bake at 400°F for 20 minutes\n6. Garnish with fresh basil"
        return recipe
    }()
    
    static let pancakes: Recipe = {
        let recipe = Recipe(name: "Buttermilk Pancakes")
        recipe.author = "Mom"
        recipe.timeRequired = 20
        recipe.servings = 6
        recipe.expertiseLevel = "Easy"
        recipe.calories = 280
        recipe.isFavorite = true
        recipe.notes = "Fluffy, golden pancakes perfect for weekend breakfast"
        recipe.ingredients = "2 cups flour\n2 tbsp sugar\n2 tsp baking powder\n1 tsp baking soda\n½ tsp salt\n2 cups buttermilk\n2 eggs\n¼ cup melted butter"
        recipe.instructions = "1. Mix dry ingredients in large bowl\n2. Whisk buttermilk, eggs, and melted butter\n3. Pour wet into dry, mix until just combined\n4. Heat griddle to 375°F\n5. Pour ¼ cup batter per pancake\n6. Flip when bubbles form, cook until golden"
        return recipe
    }()
}

