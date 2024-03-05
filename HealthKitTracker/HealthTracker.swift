//
//  HealthTracker.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

extension Double {
    func formattedString() -> String  {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

class HealthTracker: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var workouts: [String : WorkOut] = [:]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                getTodaySteps()
                getTodayCalories()
            } catch {
                print("error fetching health data")
            }
        }
    }
    
    func getTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else{
                print("error fetching today's step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let workout = WorkOut(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async{
                self.workouts["todaySteps"] = workout
            }
            print(stepCount.formattedString())
        }
        
        healthStore.execute(query)
    }
    
    func getTodayCalories() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching todays calorie data")
                return
            }
            
            let burnedCalories = quantity.doubleValue(for: .kilocalorie())
            let workout = WorkOut(id: 1, title: "Today Calories", subtitle: "Goal: 360", image: "flame", amount: burnedCalories.formattedString())
            DispatchQueue.main.async{
                self.workouts["todayCals"] = workout
            }
            print(burnedCalories.formattedString())
        }
        
        healthStore.execute(query)
    }
}



