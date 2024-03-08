//
//  HomeView.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tracker: HealthTracker
    let welcomeArray = ["Welcome", "Bienvenido", "Bienvenue"]
    @State private var currentIndex = 0
    var body: some View {
        VStack(alignment: .leading) {
            Text(welcomeArray[currentIndex])
                .font(.largeTitle)
                .padding()
                .foregroundColor(.secondary)
                .animation(.easeInOut(duration: 1), value: currentIndex)
                .onAppear(){
                    startWelcomeTimer()
                }
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                ForEach(tracker.workouts.sorted(by: {$0.value.id < $1.value.id}), id: \.key){ item in
                    WorkOutCard(workout: item.value)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func startWelcomeTimer(){
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation{
                currentIndex = (currentIndex + 1) % welcomeArray.count
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View{
        HomeView()
            .environmentObject(HealthTracker()) //allow us to see home screen even without mocked data
    }
}
