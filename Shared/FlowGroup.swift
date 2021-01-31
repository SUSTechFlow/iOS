//
//  FlowGroup.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/19.
//

import Foundation
import SwiftUI

struct FlowGroup: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var description: String
    var flowCount: Int

    private var symbolName: String
    var symbolImage: Image {
        Image(systemName: symbolName)
    }

    private enum CodingKeys : String, CodingKey {
        case name, flowCount, description, symbolName
    }
}
