//
//  FlowGroupView.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/19.
//

import SwiftUI

struct FlowItemCard: View {
    var flowItem: FlowItem
    
    var body: some View {
        VStack {
            HStack {
                flowItem.symbolImage
                    .font(.title)
                Spacer()
                Image(systemName: "ellipsis.circle.fill")
                    .font(.title)
            }
            .padding(1.0)
            HStack {
                Text(flowItem.name)
                    .bold()
                    .frame(width: 130, height: 45, alignment: .bottomLeading)
                Spacer()
            }
            .padding(1.0)œ
        }
        .padding(7.0)
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 17.0, style: .continuous)
                        .foregroundColor(flowItem.getColor()))
    }
}

struct FlowItemCardDeck: View {
    var flowItems: [FlowItem]
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            ForEach(flowItems) { flowItem in
                NavigationLink(
                    destination:FlowItemView(flowItem: flowItem), 
                    label: {
                        FlowItemCard(flowItem: flowItem)
                            .padding(2.0)
                    })
            }
        })
        .padding(.horizontal, 15)
    }
}

struct FlowGroupView: View {
    var flowGroup: FlowGroup
    
    var body: some View {
        ScrollView {
            FlowItemCardDeck(flowItems: allFlowItems.filter { flowItem in
                flowItem.inGroup(flowGroup: flowGroup)
            })
        }
        .padding(.all, 1.0)
        .navigationBarTitle(flowGroup.name)
    }
}

struct FlowGroupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlowGroupView(flowGroup: allFlowGroups[0])
                .preferredColorScheme(.light)
                .previewDevice("iPhone 12 mini")
            FlowGroupView(flowGroup: allFlowGroups[0])
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 12 mini")
        }
    }
}
