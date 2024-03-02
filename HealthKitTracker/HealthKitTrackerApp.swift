//
//  HealthKitTrackerApp.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

@main
struct HealthKitTrackerApp: App {
    @StateObject var tracker = HealthTracker()
    var body: some Scene {
        WindowGroup {
            HealthKit_TabView()
                .environmentObject(tracker)
        }
    }
}
