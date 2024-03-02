//
//  ContentView.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentPreview_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
