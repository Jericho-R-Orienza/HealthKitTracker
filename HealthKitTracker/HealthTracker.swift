//
//  HealthTracker.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import Foundation
import HealthKit

class HealthTracker: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)

            } catch {
                print("error fetching health data")
            }
        }
    }
}
