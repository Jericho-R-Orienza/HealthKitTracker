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
                WorkOutCard(workout: WorkOut(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "8,548"))
                WorkOutCard(workout: WorkOut(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "8,548"))
            }
            .padding(.horizontal)
        }
        .onAppear {
            tracker.getTodaySteps()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View{
        HomeView()
    }
}
