//
//  AtmosApp.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import SwiftUI

@main
struct AtmosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                WeatherView(viewModel: WeatherViewModel(service: WeatherServiceImpl()))
            })
        }
    }
}
