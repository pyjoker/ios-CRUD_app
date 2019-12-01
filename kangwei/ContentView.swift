//
//  ContentView.swift
//  kangwei
//
//  Created by Customer on 2019/11/30.
//  Copyright © 2019 kangwei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var eventsData = EventsData()
    @State private var showEdit = false
    @State private var selectIndex = 0
    var body: some View {
        VStack{
            if selectIndex == 0{
               PieChart(eventsData: self.eventsData).frame(width:300,height: 300)
            }
            else{
                CircleChart(eventsData: self.eventsData).frame(width:300,height: 300)
            }
            Picker(selection: $selectIndex, label: Text("choose type")){
                Text("圓餅圖").tag(0)
                Text("甜甜圈圖表").tag(1)
            }.pickerStyle(SegmentedPickerStyle()).background(Color.white)
            NavigationView{
                List{
                    ForEach(eventsData.events){ (index) in
                        NavigationLink(destination: EventEditor(eventsData: self.eventsData, editEvent: index)){EventRow(event : index)}
                    }.onDelete{(indexSet) in
                        self.eventsData.events.remove(atOffsets: indexSet)
                        
                    }.onMove { (indexSet, index) in
                        self.eventsData.events.move(fromOffsets: indexSet,
                                        toOffset: index)
                    }
                }.navigationBarTitle("我的一天")
                    .navigationBarItems(leading: EditButton(),trailing: Button(action:{self.showEdit = true},label:{Image(systemName:"plus.circle.fill")}))
                    .sheet(isPresented: $showEdit){NavigationView{EventEditor(eventsData: self.eventsData)}
                }
            }
            
        }.background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
