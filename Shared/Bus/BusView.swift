//
//  ContentView.swift
//  Shared
//
//  Created by Wycer on 2020/11/27.
//

import SwiftUI
import MapKit
import CoreData
import Combine


struct BusScheduleBrief: View {
    var busSchedules: [BusSchedule]
    let reciver = Timer.publish(every: 60, on: .current, in: .default).autoconnect()
    @State private var min = Calendar.current.component(.minute, from: Date())
    @State private var hour = Calendar.current.component(.hour, from: Date())
    
    private func getEntries(busSchedule: BusSchedule) -> [BusScheduleEntry] {
        var entries : [BusScheduleEntry] = []
        for entry in busSchedule.entries {
            let a = entry.time.h * 60 + entry.time.m
            let b = hour * 60 + min
            if  a < b - 20 {
                continue
            }
            entries.append(entry)
            if entries.count == 5 {
                break
            }
        }
        return entries
    }
    
    var body: some View {
        
        VStack {
            
            if busSchedules.count == 0 {
                Text("暂无数据").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.secondary)
            }
            
            if busSchedules.count >= 1 {
                
                
                if busSchedules.count == 2 {
                    let entries = getEntries(busSchedule: busSchedules[0])
                    if entries.count == 0 {
                        Text("今日班次已全部发出").foregroundColor(.secondary)
                    } else {
                        ForEach(entries) { entry in
                            Text(entry.description)
                        }
                    }
                } else {
                    
                    let entries = getEntries(busSchedule: busSchedules[0])
                    if entries.count == 0 {
                        Text("今日班次已全部发出").foregroundColor(.secondary)
                    } else {
                        ForEach(entries) { entry in
                            Text(entry.description)
                        }
                    }
                }
                
                
            }
        }
        .padding(.horizontal, 10)
        .onReceive(reciver) { (_) in
            let calender = Calendar.current
            
            min = calender.component(.minute, from: Date())
            hour = calender.component(.hour, from: Date())
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

// For the Cards on the main screen
struct BusCard: View {
    var busRoute: BusRoute
    
    var body: some View {
        NavigationLink(destination: BusRouteView(busRoute: busRoute)) {
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(busRoute.isPeak ? "高峰线" : "平峰线")
                            .font(.caption)
                            .foregroundColor(busRoute.isPeak ? Color(hex: 0xff5722) : Color(hex: 0x00bcd4))
                            .padding(.vertical, -5)
                        
                        HStack {
                            Text(busRoute.start)
                                .font(.title)
                                .lineLimit(1)
                                .foregroundColor(.primary)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            
                            Image(systemName: "arrow.right")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            
                            Text(busRoute.end)
                                .font(.title)
                                .lineLimit(1)
                                .foregroundColor(.primary)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        
                        Divider()
                        
                        BusScheduleBrief(busSchedules: busRoute.schedules)
                        
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .font(Font.body.weight(.semibold))
                }
                .padding(.all, 16)
                
                //                Image(systemName: "swift")
                //                    .resizable()
                //                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //                    .aspectRatio(contentMode: .fit)
                
                
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    // ATTENTION NEEDED: You will probably need to make this border darker/wider
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct BusView: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    //
    // !
    //    var foods : [Food] = []
    //
    //    var body: some View {
    //
    //        NavigationView {
    //            List {
    //
    //                ForEach(foods) {food in
    //                    FoodCell(food: food)
    //                }
    //
    //                HStack {
    //
    //                    Text("\(foods.count) foods")
    //                        .foregroundColor(.secondary)
    //
    //                    Spacer()
    //                }
    //
    //            }.navigationTitle("Foods")
    //            .toolbar {
    //                #if os(iOS)
    //                EditButton()
    //                #endif
    //            }
    //
    //
    //            Text("SwiftUI niubi").font(.largeTitle)
    //        }
    
    //!
    
    var busRoutes : [BusRoute]
    @State private var showModal = false
    
    var main: some View {
        ScrollView {
            VStack {
                ForEach (busRoutes) { br in
                    BusCard(busRoute: br)
                }.padding(.all, 5)
            }.padding(.horizontal)
        }
    }
    
    #if !os(macOS)
    var body : some View {
            main
                .navigationBarTitle(Text("校园巴士"))
    }
    #endif
    #if os(macOS)
    var body: some View {
        NavigationView {
            main
        }
    }
    #endif
}

struct BusView_Previews: PreviewProvider {
    static var previews: some View {
        BusView(busRoutes: [
            busRoute1,
            busRoute2,
            busRoute3,
            busRoute4,
            busRoute5
        ])
        //            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


