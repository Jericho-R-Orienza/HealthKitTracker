//
//  WorkOutCard.swift
//  HealthKitTracker
//
//  Created by Jericho Orienza on 3/2/24.
//

import SwiftUI

struct WorkOutCard: View {
    var body: some View {
        
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack (spacing: 20){
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5){
                        Text("Daily Steps")
                            .font(.system(size: 16))
                        
                        Text("Goal: 10,000")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    Image(systemName: "figure.walk")
                        .foregroundColor(.green)
                }
                
                .padding()
                Text("8,548")
                    .font(.system(size: 24))
            }
            .padding()
        }
    }
}

struct WorkOutCard_Previews: PreviewProvider {
    static var previews: some View{
        HomeView()
    }
}
