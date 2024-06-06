//
//  ContentView.swift
//  iCaloriesApp
//
//  Created by Dogu on 6.06.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var manageObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    /*
     Yukarıdaki örnekte,
     @FetchRequest özelliği food adında bir değişkene atanmıştır.
     Bu değişken, 'Food' türündeki verileri temsil eder.
     'Food' türü, muhtemelen uygulamanızda kullanılan bir CoreData varlığıdır.
     
     sortDescriptors parametresi,
     çekilen verilerin nasıl sıralanacağını belirtir.
     Yukarıdaki kodda, verilerin date özelliğine göre ters sıralanması belirtilmiştir.
     Bu, en yeni tarihli verinin en üstte görüntülenmesini sağlar.
     */
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))") + Text("calories").foregroundColor(.red)
                                }
                                Spacer()
                                
                                Text(calctimeSince(date: food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }.onDelete(perform: deleteFood) //tam ForEach bitiş parentezine yazıldı
                }
                .listStyle(.plain)//List bitimindeki parenteze yazıldı
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showingAddView.toggle()
                    }label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            } //NavigatioNiew içine, Vstack dışındaki paranteze yazıldı
            .sheet(isPresented: $showingAddView){ //NavigatioNiew içine, Vstack dışındaki paranteze yazıldı
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    func deleteFood(offest: IndexSet) {
        /*
         func deleteFood(offset: Int) {
             withAnimation {
                 food.remove(at: offset)
             }
         }
         
         deleteFood(offset: 5) // 5. indeksteki elemanı siler

         */
        withAnimation {
            offest.map { food[$0] }.forEach(manageObjContext.delete)
            
            DatController().save(context: manageObjContext)
        }
    }
    
    func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                //Bugünün tarihi içinde ise..
                caloriesToday += item.calories
  
            }
            /*
             Yani item, food verinin içini gezecek.
             Calendar ile bugünün tarihini alıyoruz.
             Bugünün tarihine denk geliyor ise, calorileri topluyor
             */
        }
        return caloriesToday
    }
}

#Preview {
    ContentView()
}
