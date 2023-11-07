//
//  PrecipitationView.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import SwiftUI

struct PrecipitationView: View {
    @State var weather: Weather
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.25)
                .ignoresSafeArea()
                .overlay(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
            HStack {
                Text("\(Int(weather.current.rain))")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top, 4.0)
                
                VStack(alignment: .leading) {
                    Text("\(weather.currentUnits.rain)")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.top, 4.0)
                    Text("Rain")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
        }
        .overlay(alignment: .topLeading, content: {
            HStack {
                Image(systemName: "drop.fill")
                Text("Precipitation")
            }
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, 8)
            .padding(.leading)
        })
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(height: 150)
    }
}

struct CloudCoverView: View {
    @State var weather: Weather

    var body: some View {
        ZStack {
            Color.blue.opacity(0.25)
                .ignoresSafeArea()
                .overlay(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
            HStack {
                Text("\(Int(weather.current.cloudCover))")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top, 4.0)
                
                VStack(alignment: .leading) {
                    Text("\(weather.currentUnits.cloudCover)")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.top, 4.0)
                    Text("Cloud Cover")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
        }
        .overlay(alignment: .topLeading, content: {
            HStack {
                Image(systemName: "cloud.fill")
                Text("Cloud Cover")
            }
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, 8)
            .padding(.leading)
        })
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(height: 150)
    }
}

#Preview {
    HStack {
        PrecipitationView(weather: .preview)
        CloudCoverView(weather: .preview)
    }
}
