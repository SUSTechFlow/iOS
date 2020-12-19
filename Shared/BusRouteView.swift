//
//  FoodDetail.swift
//  SUSTechFlow
//
//  Created by Wycer on 2020/11/27.
//

import SwiftUI
import MapKit

struct BusRouteView: View {
    var busRoute: BusRoute
    @State private var selectorIndex = 0;
    @State private var modeCandidates = ["工作日", "节假日"]
    var body: some View {
        VStack(alignment: .leading) {
            
            if modeCandidates.count != 1 {
                Picker("Mode", selection: $selectorIndex) {
                    ForEach(0 ..< modeCandidates.count ) { index in
                        Text(modeCandidates[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .id(modeCandidates.hashValue)
            }
            
            
            Text(modeCandidates[selectorIndex] + "时刻表").font(.title).padding(10)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 160))]) {
                    ForEach(busRoute.schedules[selectorIndex].entries) { bs in
                        Text(bs.description)
                            .font(.title2)
                            .cornerRadius(10)
                            .foregroundColor(
                                busRoute.isPeak ? .orange : .blue)
                    }
                    .padding(.vertical, 3)
                }
            }
        }
        .navigationTitle(busRoute.start + "→" + busRoute.end + (busRoute.isPeak ? "(高峰线)" : "(平峰线)"))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        .onAppear() {
            if busRoute.schedules.count == 2 {
                modeCandidates = ["工作日", "节假日"]
            }
            if busRoute.schedules.count == 1 {
                selectorIndex = 0
                if busRoute.schedules[0].type == .Holiday {
                    modeCandidates = ["节假日"]
                }
                if busRoute.schedules[0].type == .WorkingDay {
                    modeCandidates = ["工作日"]
                }
            }
        }
        
    }
}

struct BusScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            NavigationView {
                BusRouteView(busRoute: busRoute1)
            }
            
            NavigationView {
                BusRouteView(busRoute: busRoute4)
            }
            
        }
    }
}
