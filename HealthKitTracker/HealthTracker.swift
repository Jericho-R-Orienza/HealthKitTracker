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
    
    static var startOfWeekMonday: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        components.weekday = 2 //Monday
        
        return calendar.date(from: components)!
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
    
    @Published var mockWorkouts: [String: WorkOut] = [
        "todaySteps" : WorkOut(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", tintColor: .green, amount: "12,345"),
        "todayCalories" : WorkOut(id: 1, title: "Today Calories", subtitle: "Goal: 360", image: "flame", tintColor: .red, amount: "540")
    ]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let workout = HKObjectType.workoutType()
        let healthTypes: Set = [steps, calories]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                getTodaySteps()
                getTodayCalories()
                getCurrentWeekWorkOutStats()
            } catch {
                print("error fetching health data")
            }
        }
    }
    
    func getTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else{
                print("error fetching today's step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let workout = WorkOut(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", tintColor: .green, amount: stepCount.formattedString())
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
            let workout = WorkOut(id: 1, title: "Today Calories", subtitle: "Goal: 360", image: "flame", tintColor: .red, amount: burnedCalories.formattedString())
            DispatchQueue.main.async{
                self.workouts["todayCals"] = workout
            }
            print(burnedCalories.formattedString())
        }
        
        healthStore.execute(query)
    }

//function created to track a specific workout from HealthKit, in this case running
//created a different function that makes addingn new workouts easier
//Kept as referenced
//    func getWeekRunningStats() {
//        let workout = HKSampleType.workoutType()
//        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeekMonday, end: Date())
//        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
//        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: 20, sortDescriptors: nil) { _, sample, error in
//            guard let workouts = sample as? [HKWorkout], error == nil else {
//                print("error fetching week running data")
//                return
//            }
//            
//            var count: Int = 0
//            for workout in workouts {
//                let duration = Int(workout.duration)/60
//                count += duration
//            }
//            
//            let Workout = WorkOut(id: 2, title: "Running", subtitle: "Mins THis Week", image: "figure.walk", tintColor: .blue, amount: "\(count) minutes")
//            DispatchQueue.main.async{
//                self.workouts["weekRunning"] = Workout
//            }
//            
//        }
//        healthStore.execute(query)
//    }
    
   
    
    func getCurrentWeekWorkOutStats() {
        let workout = HKSampleType.workoutType()
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeekMonday, end: Date())
        let query = HKSampleQuery(sampleType: workout, predicate: timePredicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error getching workout data")
                return
            }
            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var soccerCount: Int = 0
            var swimmingCount: Int = 0
            var stairCount: Int = 0
            var tennisCount: Int = 0
            for workout in workouts {
                if workout.workoutActivityType == .running {
                    let duration = Int(workout.duration)/60
                    runningCount += duration
                } else if workout.workoutActivityType == .traditionalStrengthTraining {
                    let duration = Int(workout.duration)/60
                    strengthCount += duration
                } else if workout.workoutActivityType == .soccer {
                    let duration = Int(workout.duration)/60
                    soccerCount += duration
                } else if workout.workoutActivityType == .swimming {
                    let duration = Int(workout.duration)/60
                    swimmingCount += duration
                } else if workout.workoutActivityType == .stairClimbing {
                    let duration = Int(workout.duration)/60
                    stairCount += duration
                } else if workout.workoutActivityType == .tennis {
                    let duration = Int(workout.duration)/60
                    tennisCount += duration
                }
                
            }
            let runningWorkout = WorkOut(id: 2, title: "Running", subtitle: "Mins This week", image: "figure.walk", tintColor: .green, amount: "\(runningCount) minutes")
            let strengthWorkout = WorkOut(id: 3, title: "Weight Lifting", subtitle: "This week", image: "dumbbell", tintColor: .yellow, amount: "\(strengthCount) minutes")
            let soccerWorkout = WorkOut(id: 4, title: "Soccer", subtitle: "Mins This week", image: "soccerball", tintColor: .white, amount: "\(soccerCount) minutes")
            let swimmingWorkout = WorkOut(id: 5, title: "Swimming", subtitle: "Mins This week", image: "figure.pool.swim", tintColor: .blue, amount: "\(swimmingCount) minutes")
            let stairWorkout = WorkOut(id: 6, title: "Stair Master", subtitle: "Mins This week", image: "figure.stair.stepper", tintColor: .gray, amount: "\(stairCount) minutes")
            let tennisWorkout = WorkOut(id: 7, title: "Tennis", subtitle: "Mins This week", image: "tennis.racket", tintColor: .pink, amount: "\(tennisCount) minutes")


            DispatchQueue.main.async{
                self.workouts["weekRunning"] = runningWorkout
                self.workouts["weekWeightLift"] = strengthWorkout
                self.workouts["weekSoccer"] = soccerWorkout
                self.workouts["weekSwimming"] = swimmingWorkout
                self.workouts["weekStairs"] = stairWorkout
                self.workouts["weekTennis"] = tennisWorkout
            }
        }
        healthStore.execute(query)
    }
}



