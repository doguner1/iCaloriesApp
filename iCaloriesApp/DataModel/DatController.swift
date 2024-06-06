//
//  DatController.swift
//  iCaloriesApp
//
//  Created by Dogu on 6.06.2024.
//

import Foundation
import CoreData

class DatController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel") //DataCore ismi
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        //Önce verilerimizi kaydetme kodunu yazdık. Bizim için ilk önemli nokta bu
        do {
            try context.save()
            print("Data saved!!!")
        } catch {
            print("Not save the data...")
        }
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        //Verileri eklemek için gerekeli kodları yazdık
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
}
