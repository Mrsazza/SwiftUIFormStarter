//
//  SettingsView.swift
//  SwiftUIList
//
//  Created by Sazza on 20/10/21.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
   
    @State private var selectedOrder = DisplayOrderType.alphabetical
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settingStore : SettingStore
    // MARK: - BODY
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("SORT PREFERNECE"))
                {
                    Picker(selection: $selectedOrder, label: Text("Display Order")){
                        ForEach(DisplayOrderType.allCases, id: \.self){
                            orderType in
                            Text(orderType.text)
                        }
                    }
                }
                Section(header: Text("FILTER PREFERENCE"))
                {
                    Toggle(isOn: $showCheckInOnly){
                        Text("Show Check-in Only")
                    }
                    
                    Stepper(onIncrement: {
                        self.maxPriceLevel += 1
                        if self.maxPriceLevel > 5{
                            self.maxPriceLevel = 5
                        }
                    }, onDecrement: {
                        self.maxPriceLevel -= 1
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                        }
                    }){
                        Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                    }
                }
            }//: FORM
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(trailing:
                Button(action: {
                
                self.settingStore.showCheckInOnly = self.showCheckInOnly
                self.settingStore.displayOrder = self.selectedOrder
                self.settingStore.maxPriceLevel = self.maxPriceLevel
                self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .font(.subheadline)
                        .foregroundColor(.black)
            })
            )
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .foregroundColor(.black)
            })
            )
            
        }//: NAVIGATION VIEW
        .onAppear{
            self.selectedOrder = self.settingStore.displayOrder
            self.showCheckInOnly = self.settingStore.showCheckInOnly
            self.maxPriceLevel = self.settingStore.maxPriceLevel
        }
    }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SettingStore())
    }
}

