//
//  AppDetailCell.swift
//  35-Seminar-SwiftUI
//
//  Created by 최지석 on 11/23/24.
//

import SwiftUI

struct AppDetailCell: View {
    
    var appModel: AppModel
    
    var body: some View {
        HStack {
            Image(systemName: appModel.imageName)
                .resizable()
                .frame(width: 56, height: 56)
                .aspectRatio(contentMode: .fit)
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
            
            VStack {
                Spacer().frame(height: 20)
                Text("\(appModel.ranking)")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(width: 20)
            
            VStack(alignment: .leading) {
                Text(appModel.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(appModel.subTitle)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            Button {
                // buttonHandler?()
            } label: {
                Text(appModel.downloadState.rawValue)
                    .frame(width: 64, alignment: .center)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                    .clipShape(.buttonBorder)
            }
        }
    }
}

