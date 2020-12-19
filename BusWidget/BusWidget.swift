//
//  BusWidget.swift
//  BusWidget
//
//  Created by Wycer on 2020/11/28.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        print(entries)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}


struct BusRouteScheduleEntry : Identifiable {
    let id = UUID()
    var busScheduleEntry: BusScheduleEntry
    var busRoute: BusRoute
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

struct BusBriefWithDestination: View {
    var destination: String
    let limit = 5
    
    func getEntries() -> [BusRouteScheduleEntry] {
        let hour = Calendar.current.component(.hour, from: Date())
        let min = Calendar.current.component(.minute, from: Date())
        var entries : [BusRouteScheduleEntry] = []
        for route in allRoutes {
            if route.end != destination {
                continue
            }
            var cnt = 0
            for schedule in route.schedules {
                for entry in schedule.entries {
                    let a = entry.time.h * 60 + entry.time.m
                    let b = hour * 60 + min
                    if  a < b - 20 {
                        continue
                    }
                    entries.append(BusRouteScheduleEntry(busScheduleEntry: entry, busRoute: route))
                    cnt += 1
                    if cnt == limit {
                        break
                    }
                }
            }
        }
        
        entries.sort { (a, b) -> Bool in
            if a.busScheduleEntry.time.h == b.busScheduleEntry.time.h {
                return a.busScheduleEntry.time.m < b.busScheduleEntry.time.m
            }
            return a.busScheduleEntry.time.h < b.busScheduleEntry.time.h
        }
        
        
        
        return Array(entries[0 ..< limit])
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("→" + destination)
            
            ForEach (getEntries()) { entry in
                Text(entry.busScheduleEntry.description)
                    .foregroundColor(entry.busRoute.isPeak ? Color(hex: 0xff5722) : Color(hex: 0x00bcd4))
            }
        }.padding(3)
    }
}

struct BusWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            BusBriefWithDestination(destination: "欣园")
            BusBriefWithDestination(destination: "科研楼")
        }
        
        
    }
}

@main
struct BusWidget: Widget {
    let kind: String = "BusWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            BusWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("SUSTech Bus")
        .description("School Bus Widget by SUSTech Flow")
    }
}

struct BusWidget_Previews: PreviewProvider {
    static var previews: some View {
        BusWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
