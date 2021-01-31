//
//  FlowItem.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/19.
//

import Foundation
import SwiftUI

//enum FlowItemState: String, Codable {
//    case active, inactive
//}

struct FlowItem: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var description: String
    var colorName: String
    var groupName: String
    var isFavorite: Bool

//    var state: FlowItemState

    private var symbolName: String
    var symbolImage: Image {
        Image(systemName: symbolName)
    }

    private enum CodingKeys: String, CodingKey {
        case name, description, colorName, groupName, isFavorite, symbolName
    }

    func inGroup(flowGroup: FlowGroup) -> Bool {
        if flowGroup.name == "All Flows" {
            return true
        }
        return self.groupName == flowGroup.name
    }

    func getColor() -> Color {
        switch self.colorName {
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "yellow":
            return Color.yellow
        case "green":
            return Color.green
        case "blue":
            return Color.blue
        case "purple":
            return Color.purple
        case "gray":
            return Color.gray
        default:
            return Color.accentColor
        }
    }
}
