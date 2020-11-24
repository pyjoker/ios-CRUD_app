//
//  PieChart.swift
//  kangwei
//
//  Created by Customer on 2019/12/1.
//  Copyright © 2019 kangwei. All rights reserved.
//

import SwiftUI

//struct MyChart : Shape{
//    var startAngle : Angle
//    var endAngle : Angle
//
//    func path(in rect :CGRect)-> Path{
//        Path{(path) in
//            let center = CGPoint(x:rect.midX,y:rect.midY)
//            path.move(to:center)
//            path.addArc(center:center,radius:rect.midX,startAngle: startAngle,endAngle: endAngle,clockwise: false)
//        }
//    }
//}

struct PieChart: View {
    var eventsData : EventsData
    var percentages : [Double]
    var angles : [Angle]
    var types = ["金融","電子","傳產","指數","生技醫療","觀光","運輸"]
    var colors :[Color]
    
    init(eventsData : EventsData){
        self.eventsData = eventsData
        if eventsData.events.count == 0{
            self.colors = [Color.white,Color.white,Color.white,Color.white,Color.white,Color.white,Color.white]
            self.percentages = [1.0]
            self.angles = [.degrees(0),.degrees(0),.degrees(0),.degrees(0),.degrees(0),.degrees(0),.degrees(0)]
        }
        else{
            percentages = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            angles = [Angle]()
            colors = [Color.blue,Color.red,Color.yellow,Color.green,Color.orange,Color.purple,Color.gray]
            var totalTime = 0;
            for event in self.eventsData.events{
                totalTime += event.time;
                for index in 0...6{
                    if(types[index] == event.type){
                        percentages[index] += Double(event.time)
                    }
                }
            }
            var startDegree : Double = 0
            for index in 0...6{
                percentages[index] /= Double(totalTime)
                angles.append(.degrees(startDegree))
                startDegree += 360 * percentages[index]
            }
        }
    }
    var body: some View {
        ZStack{
            ForEach(angles.indices){ (index) in
                ExtractedView(index:index,angles: self.angles,colors: self.colors)
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(eventsData: EventsData())
    }
}


struct ExtractedView: View {
    var index : Int
    var angles : [Angle]
    var colors : [Color]
    var body: some View {
        ZStack{
            if index == (angles.count-1){
                MyChart(startAngle: angles[index], endAngle: .degrees(360)).fill(colors[index])
            }
            else{
                MyChart(startAngle: angles[index], endAngle: angles[index+1]).fill(colors[index])
            }
        }
    }
}

struct MyChart : Shape{
    var startAngle : Angle
    var endAngle : Angle

    func path(in rect :CGRect)-> Path{
        Path{(path) in
            let center = CGPoint(x:rect.midX,y:rect.midY)
            path.move(to:center)
            path.addArc(center:center,radius:rect.midX,startAngle: startAngle,endAngle: endAngle,clockwise: false)
        }
    }
}
