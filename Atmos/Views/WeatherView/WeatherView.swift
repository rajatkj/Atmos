//
//  WeatherView.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import SwiftUI

struct WeatherView: View {
    @State var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            AnimatedGradientView()
            
            if !viewModel.isLoading {
                weatherContent
            }
        }
        .overlay(alignment: .bottomTrailing, content: {
            
            NavigationLink(destination: LocationView(viewModel: LocationViewModel(service: WeatherLocationService()), selectedLocation: $viewModel.selectedLocation)) {
                
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 56)
                        .shadow(radius: 10)
                    Image(systemName: "magnifyingglass")
                        .tint(.gray)
                }
                .padding()
                .padding(.trailing, 16)
                    
            }
        })
        .task {
            await viewModel.getWeather()
        }
        .onReceive(NotificationCenter.default.publisher(for:  Notification.Name("ChangedLocation"), object: nil)) { _ in
            Task {
                await viewModel.getWeather()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .task(id: viewModel.selectedLocation?.placeId) {
            await viewModel.getWeather()
        }
        .refreshable {
            Task {
                await viewModel.getWeather()
            }
        }
    }
    
    private var weatherContent: some View {
        ScrollView {
            Text(viewModel.placeName)
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.top)
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(viewModel.weather?.current.temperature2M.description ?? "")
                    .font(.system(size: 128))
                    .fontWeight(.medium)
                
                Text(viewModel.weather?.currentUnits.temperature2M ?? "")
                    .font(.subheadline)
            }
            .shadow(radius: 10)

            Text(" Feels like \(viewModel.weather?.apparentTemperature ?? "")")
                .font(.caption)
            
            Spacer()
            if let weather = viewModel.weather {
                WindDirectionView(weather: weather)
                HStack {
                    PrecipitationView(weather: weather)
                    CloudCoverView(weather: weather)
                }
                .padding(.horizontal)
            }
        }
        .foregroundStyle(.white)
        .animation(nil)
    }
}

#Preview {
    NavigationView(content: {
        WeatherView(viewModel: .preview)
    })
}
