//
//  AddFoodView.swift
//  iCaloriesApp
//
//  Created by Dogu on 6.06.2024.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var manageObjContext
    @Environment(\.dismiss) var dismm //doğrudan ana gezinmeye gidecek
    
    @State private var name = ""
    @State private var calories: Double = 0
    var body: some View {
        Form {
            Section {
                TextField("Food name", text: $name)
                
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                    //step: adım sayısı
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        DatController().addFood(name: name, calories: calories, context: manageObjContext)
                        dismm()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AddFoodView()
}
