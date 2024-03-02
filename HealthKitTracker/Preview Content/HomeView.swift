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
                WorkOutCard()
                
                WorkOutCard()
            }
            .padding(.horizontal)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View{
        HomeView()
    }
}
