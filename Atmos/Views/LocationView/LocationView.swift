//
//  LocationView.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import SwiftUI

struct LocationView: View {
    @State var viewModel: LocationViewModel
    @Binding var selectedLocation: Location?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.locations) { location in
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(location.displayName)
                            .lineLimit(1)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .padding()
                }
                .onTapGesture {
                    self.selectedLocation = location
                    dismiss()
                }
            }
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) { oldValue, newValue in
            viewModel.getLocations()
        }
    }
}

#Preview {
    NavigationView(content: {
        LocationView(viewModel: .preview, selectedLocation: .constant(.preview))
    })
}
