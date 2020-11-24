//
//  EventEditor.swift
//  kangwei
//
//  Created by Customer on 2019/11/30.
//  Copyright © 2019 kangwei. All rights reserved.
//

import SwiftUI

struct EventEditor: View {
    var types = ["金融","電子","傳產","指數","生技醫療","觀光","運輸"]
    @Environment(\.presentationMode) var preMode
    @State private var selectIndex = 0
    @State private var hours = 0
    @State private var mins = 50
    @State private var text = ""
    @State private var name = ""
    var eventsData : EventsData
    var editEvent : Event?
    var body: some View {
            Form{
                Picker(selection: $selectIndex, label: Text("choose type")){
                    Text(self.types[0]).tag(0)
                    Text(self.types[1]).tag(1)
                    Text(self.types[2]).tag(2)
                    Text(self.types[3]).tag(3)
                    Text(self.types[4]).tag(4)
                    Text(self.types[5]).tag(5)
                    Text(self.types[6]).tag(6)
                }
                Stepper("股數  :   \(hours)",value: $hours, in:0...100000,step:1000)
//                HStack{
//                Text("股數: \(Int(self.hours))股")
//            .padding(.trailing)
//            Slider(value: self.$hours, in: 0...100000, step: 1000)
//            }
                Stepper("買價  :   \(mins)",value: $mins, in:0...200,step:10)
                TextField("股票代號或名稱", text: $text)
            }.navigationBarTitle(editEvent == nil ?"新增事件":"修改事件")
                .navigationBarItems(trailing: Button("save"){
                                        let event = Event(type: self.types[self.selectIndex], time: self.hours*self.mins,hours:self.hours,mins:self.mins, notice: self.text, name: name)
                    if let editEvent = self.editEvent{
                        let index = self.eventsData.events.firstIndex{
                            return $0.id == editEvent.id
                            }!
                        self.eventsData.events[index] = event
                    }
                    else{
                        self.eventsData.events.insert(event,at:0)
                    }
                    self.preMode.wrappedValue.dismiss()})
                .onAppear{
                    if let editEvent = self.editEvent{
                        self.selectIndex = self.types.firstIndex(of: editEvent.type) ?? 0
                        self.hours = editEvent.hours
                        self.mins = editEvent.mins
                        self.text = editEvent.notice
                    }
            }
                    
    }
}

struct EventEditor_Previews: PreviewProvider {
    static var previews: some View {
        EventEditor(eventsData: EventsData())
    }
}
