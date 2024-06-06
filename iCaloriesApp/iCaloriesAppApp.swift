//
//  iCaloriesAppApp.swift
//  iCaloriesApp
//
//  Created by Dogu on 6.06.2024.
//

import SwiftUI
import CoreData

@main
struct iCaloriesAppApp: App {
    @StateObject private var dataController = DatController()
    //Veritabanımız enjekte etmemiz gerekiyor (VeriTabanımızın adı DatController)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
