//
//  HealthKit_TabView.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

struct HealthKit_TabView: View {
    @EnvironmentObject var tracker: HealthTracker
    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag("Home")
                .tabItem{
                    Image(systemName: "house")
                }
            
            ContentView()
                .tag("Content")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct HealthKit_TabView_Previews: PreviewProvider {
    static var previews: some View{
        // Create an instance of HealthTracker
       let tracker = HealthTracker()
       // Inject it into HealthKit_TabView's environment
       HealthKit_TabView().environmentObject(tracker)
    }
}
