//
//  ContentView.swift
//  35-Seminar-SwiftUI
//
//  Created by 최지석 on 11/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var profileImageName: String = "person"
    @State var department: String = "iOS"
    @State var name: String = "최지석"
    @State var generation: String = "00년생"
    @State var role: String = "파트원"
    @State var mbti: String = "INFP"
    
    var body: some View {
        VStack {
            ProfileImageView(profileImageName: profileImageName)
            ProfileInfoView(department: department,
                            name: name,
                            generation: generation,
                            role: role,
                            mbti: mbti)
        }
        .padding()
    }
}

struct ProfileImageView: View {

    var profileImageName: String

    var body: some View {
        Image(systemName: profileImageName)
          .resizable()
          .frame(width: 250, height: 250)
          .clipShape(Circle())
          .overlay {
            Circle().stroke(
              .white,
              lineWidth: 4
            )
          }
          .shadow(radius: 7)
    }
}

struct ProfileInfoView: View {
    
    var department: String
    var name: String
    var generation: String
    var role: String
    var mbti: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(department)
                    Text(name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                }
                Text(generation)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(role)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
                Text(mbti)
                    .fontWeight(.semibold)
                    .foregroundStyle(.mint)
            }
        }
    }
}


#Preview {
    ContentView()
}
