//
//  ContentView.swift
//  HappyHour
//
//  Created by Tim Smith on 6/22/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Place.name) private var places: [Place]
        // Place(name: "First"),
        //Place(name: "Second")
    @Environment(\.modelContext) private var context
    
    @State private var showAddAlert = false
    @State private var showPickOneAlert = false
    @State private var newPlace = ""
    @State private var placeYouShouldGo = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach (places) { place in
                        VStack {
                            Text(place.name)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    //.onMove(perform: moveItems)
                }
                .navigationTitle(Text("Happy Hour Places"))
                HStack {
                    Spacer()
                    EditButton ().buttonStyle(.borderedProminent)
                    Spacer()
                    Button("Pick one") {
                        //print("You pressed pick one.")
                        showPickOneAlert.toggle()
                        placeYouShouldGo = pickOne()
                        //print ("You should go to \(placeYouShouldGo)")
                    }.buttonStyle(.borderedProminent)
                        .alert("You should definitely go to\r\n\r\n \(placeYouShouldGo)!!!", isPresented: $showPickOneAlert) {
                            Button("You're so right", role: .cancel) { }
                        } //message: {
                            //Text("You should go to \(placeYouShouldGo)")
                        //}
                    Spacer()
                    Button("Add") {
                        //print("You pressed Add.")
                        showAddAlert.toggle()
                    }.buttonStyle(.borderedProminent)
                        .alert("What's the name of the new place?", isPresented: $showAddAlert) {
                            TextField("New Place", text: $newPlace)
                                .autocorrectionDisabled()
                            Button("Cancel", role: .cancel) {
                                //Nothing needed here.
                            }
                            Button("OK", action: submit)
                        }
                        
                    Spacer()
                }
                //.task {
                    //context.insert(Place(name: "First"))
                    //context.insert(Place(name: "Second"))
                    //context.insert(Place(name: "Third"))
                    //context.insert(Place(name: "Fourth"))
                    //context.insert(Place(name: "Fifth"))
                    //context.insert(Place(name: "Sixth"))
                    //context.insert(Place(name: "Seventh"))
                    //context.insert(Place(name: "Eighth"))
                //}
            }
        }
    }
    func deleteItems(at indexSet: IndexSet) {
        //context.remove(atOffsets: offsets)
        for index in indexSet {
            context.delete(places[index])
        }
    }
    //func moveItems (fromIndex: IndexSet, newIndex: Int) {
        //places.move(fromOffsets: fromIndex, toOffset: newIndex)
    //}
    func submit() {
        let newOption = Place(name: newPlace)
        context.insert(newOption)
        newPlace = ""
    }
    func pickOne() -> String {
        let shuffled = places.shuffled()
        //print(shuffled[0].name)
        //if let randomPlace = shuffled[0] {
            //placeYouShouldGo = randomPlace.name
        //}
        return("\(shuffled[0].name)")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Place.self, inMemory: true)
}
