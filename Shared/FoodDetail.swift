////
////  FoodDetail.swift
////  SUSTechFlow
////
////  Created by Wycer on 2020/11/27.
////
//
//import SwiftUI
//
//struct FoodDetail: View {
//    var food: Food
//    @State private var zoomed = false
//
//    var body: some View {
//        VStack {
//            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
//
//            Image(food.name)
//                .resizable()
//                .aspectRatio(contentMode: zoomed ? .fill : .fit)
//                .onTapGesture {
//                    withAnimation {
//                        zoomed.toggle()
//                    }
//                }
//
//            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
//
//            if !zoomed {
//
//                HStack {
//
//                    Spacer()
//
//                    Label("Spicy", systemImage: "flame.fill")
//
//                    Spacer()
//                }
//                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                .font(Font.headline.smallCaps())
//                .background(Color.red)
//                .foregroundColor(Color.yellow)
//                .transition(.move(edge: .bottom))
//            }
//        }
//        .navigationTitle(food.name)
//        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct FoodDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//
//                NavigationView {
//                    FoodDetail(food: foodsData[0])
//                }
//
//                NavigationView {
//                    FoodDetail(food: foodsData[1])
//                }
//        }
//    }
//}
