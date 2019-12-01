//
//  EventRow.swift
//  kangwei
//
//  Created by Customer on 2019/11/30.
//  Copyright © 2019 kangwei. All rights reserved.
//

import SwiftUI

struct EventRow: View {
    var event: Event
    var colors = [Color.blue,Color.red,Color.yellow,Color.green,Color.orange,Color.purple,Color.gray]
    var types = ["睡覺","吃飯","運動","上班","上課","休閒","約會"]
    var body: some View {
        HStack{
            Text(event.type)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
            Spacer()
            Text("時間： \(event.time/60) 小時 \(event.time%60) 分鐘")
                .fontWeight(.bold)
        }.background(colors[types.firstIndex(of: event.type) ?? 0])
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event : Event(type: "睡覺", time: 80, notice: "gg"))
    }
}
