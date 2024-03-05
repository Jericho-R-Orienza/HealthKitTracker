//
//  HomeView.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tracker: HealthTracker
    var body: some View {
        VStack{
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ForEach(tracker.workouts.sorted(by: {$0.value.id < $1.value.id}), id: \.key){ item in
                    WorkOutCard(workout: item.value)
                }
            }
            .padding(.horizontal)
        }
        //removed onAppear becasue we are instead calling it in HealthTracker when we init
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View{
        HomeView()
    }
}
