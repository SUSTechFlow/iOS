//
//  CalendarView.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/19.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationView {
            Text("Entry to Personal Calendar")
                .navigationBarTitle("Calendar")
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
