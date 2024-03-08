//
//  WorkOutCard.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

struct WorkOut {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let tintColor: Color
    let amount: String
}

struct WorkOutCard: View {
    @State var workout: WorkOut
    
    var body: some View {
        
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack (spacing: 20){
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5){
                        Text(workout.title)
                            .font(.system(size: 16))
                        
                        Text(workout.subtitle)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    Image(systemName: workout.image)
                        .foregroundColor(workout.tintColor)
                }
                
                .padding()
                Text(workout.amount)
                    .font(.system(size: 24))
                    .minimumScaleFactor(0.6)
                    .bold()
                    .padding()
                
            }
            .padding()
        }
    }
}

struct WorkOutCard_Previews: PreviewProvider {
    static var previews: some View{
        WorkOutCard(workout: WorkOut(id: 0, title: "Daily Steps", subtitle: "Goal", image: "figure.walk", tintColor: .green, amount: "8,548"))
    }
}
