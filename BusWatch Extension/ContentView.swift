//
//  ContentView.swift
//  BusWatch Extension
//
//  Created by Wycer on 2020/12/7.
//

import SwiftUI


struct BusView: View {
    @State private var busViewModel: BusViewModel = BusViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    BusTableView(direction: "欣园", previous: busViewModel.XinYuanPrevious, next: busViewModel.XinYuanNext, iconName: "chevron.up")
                    
                    BusTableView(direction: "科研楼", previous: busViewModel.KeYanLouPrevious, next: busViewModel.KeYanLouNext, iconName: "chevron.down")
                }
                
                BusWorkView(isOnWeekDay: busViewModel.isOnWeekDay)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer(minLength: 50)
                
                VStack {
                    Button{
                        self.busViewModel.refreshBus()
                    } label: {
                        Text("更新时间")
                    }
                    
                    Button {
                        self.busViewModel.swichModel()
                        
                    } label:{
                        Text("变更运行模式")
                    }
                }
            }
        }
        
    }
}

struct BusTableView: View {
    var direction: String
    var previous: String
    var next: String
    var iconName: String
    
    var body : some View {
        HStack {
            Image(systemName: iconName)
                .font(.title)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Group {
                    Text("\(direction)方向")
                        .font(.headline)
                    Text("上一班 \(previous)")
                    Text("下一班 \(next)")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
}

struct ContentView: View {
    var body: some View {
        BusView()
    }
}


struct BusWorkView: View {
    var isOnWeekDay: Bool
    
    var body: some View {
        Group {
            if isOnWeekDay {
                Text("今天校巴按工作日运行")
                    .fontWeight(.light)
            } else {
                Text("今天校巴按节假日运行")
                    .fontWeight(.light)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
