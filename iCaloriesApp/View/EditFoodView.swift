//
//  EditFoodView.swift
//  iCaloriesApp
//
//  Created by Dogu on 6.06.2024.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var manageObjContext
    @Environment(\.dismiss) var dismm //doğrudan ana gezinmeye gidecek
    
    var food: FetchedResults<Food>.Element
    @State private var name = ""
    @State private  var calories: Double = 0
    
    var body: some View {
        Form{
            Section {
                TextField("\(food.name!)", text: $name)
                    .onAppear{ //sayfa açıldığı an, name değeri food.name olacak, calories ile food.calories den veri alacak
                        //food değerinin niteliklerini FetchedResults<Food>.Element buradan alıyor
                        name = food.name!
                        calories = food.calories
                    }//.onAppear => Sayfa Yüklendiği an, açıldığı an yapılacaklar diyebiliriz.
                
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        DatController().editFood(food: food, name: name, calories: calories, context: manageObjContext)
                        dismm()
                    }
                    Spacer()
                }
            }
        }
    }
}

