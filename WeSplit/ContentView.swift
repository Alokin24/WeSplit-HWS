//
//  ContentView.swift
//  WeSplit
//
//  Created by Nikola Anastasovski on 4.3.21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeopleIndex = 0
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    var possibleNumberOfPeople: [Int] {
        var arr: [Int] = []
        for i in 2..<100 {
            arr.append(i)
        }
        return arr
    }
    
    var peopleCount: Double {
        Double(possibleNumberOfPeople[numberOfPeopleIndex])
    }
    
    var tipSelection: Double {
        Double(tipPercentages[tipPercentage])
    }
    
    var checkPrice: Double {
        Double(checkAmount) ?? 0
    }
    
    var totalPerPerson: Double {
        checkPrice * (1 + tipSelection / 100) / peopleCount
    }
    
    var totalAmount: Double {
        checkPrice * (1 + tipSelection / 100)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeopleIndex) {
                        ForEach(0..<98) {
                            Text("\(possibleNumberOfPeople[$0]) people.")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?"))  {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount")) {
                    Text(String(format: "$%.2f", totalAmount))
                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
