//
//  FlowItemView.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/20.
//

import SwiftUI

struct FlowItemView: View {
    var flowItem: FlowItem
    
    var body: some View {
        if flowItem.name == "Bus Schedule" {
            BusView(busRoutes: [
                busRoute1,
                busRoute2,
                busRoute3,
                busRoute4,
                busRoute5
            ])
        }else {
            Text(flowItem.description)
                .navigationTitle(flowItem.name)
        }
    }
}

struct FlowItemView_Previews: PreviewProvider {
    static var previews: some View {
        FlowItemView(flowItem: allFlowItems[0])
    }
}
