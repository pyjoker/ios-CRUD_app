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
    var types = ["金融","電子","傳產","指數","生技醫療","觀光","運輸"]
    var body: some View {
        HStack{
            Text(event.type)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
            Spacer()
            Text("股數： \(event.hours) 一股 \(event.mins) 元")
                .fontWeight(.bold)
        }.background(colors[types.firstIndex(of: event.type) ?? 0])
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event : Event(type: "金融", time: 80, hours:2000,mins:100,notice: "gg",name:"2330"))
    }
}
