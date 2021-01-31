//
//  BusSchedule.swift
//  SUSTechFlow
//
//  Created by Wycer on 2020/12/6.
//

import Foundation


struct BusScheduleTime: CustomStringConvertible {
    let h: Int
    let m: Int
    
    public var description: String { return String(format: "%02d:%02d", h, m) }
}


struct BusScheduleEntry : Identifiable, CustomStringConvertible {
    let id = UUID()
    let time: BusScheduleTime
    
    public var description: String { return "\(time)" }
}


enum BusScheduleType {
    case WorkingDay
    case Holiday
    case All
}


struct BusSchedule: Identifiable {
    let id = UUID()
    let type: BusScheduleType
    let entries : [BusScheduleEntry]
}
