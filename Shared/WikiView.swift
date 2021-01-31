//
//  WikiView.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/21.
//

import SwiftUI

struct WikiView: View {
    var body: some View {
        NavigationView {
            Text("Entry to SUSTech Wiki")
                .navigationTitle("SUSTech Wiki")
        }
    }
}

struct WikiView_Previews: PreviewProvider {
    static var previews: some View {
        WikiView()
    }
}
