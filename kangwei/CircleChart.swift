//
//  CircleChart.swift
//  kangwei
//
//  Created by Customer on 2019/12/1.
//  Copyright © 2019 kangwei. All rights reserved.
//

import SwiftUI

struct CircleChart: View {
    var eventsData : EventsData
    var percentages : [Double]
    var degree : [CGFloat]
    var types = ["睡覺","吃飯","運動","上班","上課","休閒","約會"]
    var colors : [Color]
    var totalTime : Int = 0
    init(eventsData : EventsData){
        self.eventsData = eventsData
        if eventsData.events.count == 0{
            colors = [Color.white,Color.white,Color.white,Color.white,Color.white,Color.white,Color.white]
            percentages = [1.0]
            degree = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
        }
        else{
            percentages = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            colors = [Color.blue,Color.red,Color.yellow,Color.green,Color.orange,Color.purple,Color.gray]
            for event in self.eventsData.events{
                totalTime += event.time;
                for index in 0...6{
                    if(types[index] == event.type){
                        percentages[index] += Double(event.time)
                    }
                }
            }
            for index in 0...6{
                percentages[index] /= Double(totalTime)
            }
            degree = [0.0,CGFloat(percentages[0])]
            for index in 2...6{
                degree.append(CGFloat(percentages[index-1]) + degree[index-1])
            }
        }
    }
    var body: some View {
        ZStack{
            ForEach(degree.indices){ (index) in
                circleView(index:index,degree:self.degree,colors: self.colors)
            }
            Text("total time : \(totalTime/60)小時 \(totalTime%60)分鐘")
                .fontWeight(.bold)
                .foregroundColor(Color(red: 255, green: 200, blue: 0.0, opacity: 1.0))
        }.frame(width :250,height: 250)
    }
}

struct CircleChart_Previews: PreviewProvider {
    static var previews: some View {
        CircleChart(eventsData: EventsData())
    }
}


struct circleView: View {
    var index : Int
    var degree : [CGFloat]
    var colors : [Color]
    var body: some View {
        VStack{
            if index == (self.degree.count-1){
                Circle()
                    .trim(from: self.degree[index], to:1)
                    .stroke(self.colors[index],lineWidth: CGFloat(30))
            }
            else{
                Circle()
                    .trim(from: self.degree[index], to:self.degree[index+1])
                    .stroke(self.colors[index],lineWidth: CGFloat(30))
            }
        }
    }
}
