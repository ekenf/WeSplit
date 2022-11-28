//
//  ContentView.swift
//  WeSplit Project
//
//  Created by Furkan on 2.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var cimri = false
        
    var totalPerPerson: String {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return formatter.string(from : NSNumber (value: amountPerPerson)) ?? "$0"
    }
    
    var grandTotal: String {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        return formatter.string(from: NSNumber (value: grandTotal)) ?? "$0"
    }
    
    
    func CimriMi(_ sayi : Int) {
            if sayi == 0 {
                cimri = true
            }
    }
    
    var body: some View {
        NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        
                        Picker("Number of people", selection: $numberOfPeople){
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage){
                            ForEach(0..<101) {
                                Text($0, format: .percent)
                            }
                        }.onChange(of: tipPercentage){
                            _ in CimriMi(tipPercentage)
                        }

                    }
                    header : {
                        Text("How much do you want to leave?")
                    }
                    
                    Section{
                        Text(totalPerPerson)
                    } header : {
                        Text("Amount Per Person:")
                    }
                    Section{
                        Text(grandTotal)
                    }
                    header : {
                        Text("Total Price:")
                    }
                    .foregroundColor(cimri ? .red : .primary)
                    
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
