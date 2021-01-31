//
//  MyFlowsView.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/19.
//

import SwiftUI

struct FlowGroupRow: View {
    var flowGroup: FlowGroup

    var body: some View {
        HStack {
            flowGroup.symbolImage
                .frame(width: 20, height: 20, alignment: .center)
                .foregroundColor(.accentColor)
            Text(flowGroup.name)
            Spacer()
            Text("\(flowGroup.flowCount)")
                .foregroundColor(.secondary)
        }
    }
}

struct FavoriteFlowItemCard: View {
    var favoriteFlowItem: FlowItem

    var body: some View {
        VStack {
            HStack {
                favoriteFlowItem.symbolImage
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.accentColor)
                Text(favoriteFlowItem.name)
            }
        }
    }
}

struct MyFlowsView: View {
    var body: some View {
        NavigationView {
            List {
//                Section(header: Text("groups")) {
                ForEach(allFlowGroups) { flowGroup in
                    NavigationLink(
                        destination: FlowGroupView(flowGroup: flowGroup),
                        label: {
                            FlowGroupRow(flowGroup: flowGroup)
                        })
                }
//                }
//                Section(header: Text("favorites")) {
//                }
            }
//            .listStyle(InsetGroupedListStyle())
            .padding(.all, 1.0)
            .navigationBarTitle("SUSTech Flow")
//            .navigationBarItems(
//                leading: EditButton()
//            )
        }
    }
}

struct MyFlowsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyFlowsView()
            MyFlowsView()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
