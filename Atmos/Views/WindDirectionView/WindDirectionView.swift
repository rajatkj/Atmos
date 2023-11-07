//
//  WindDirectionView.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import SwiftUI

struct WindDirectionView: View {
    
    @State var weather: Weather
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.25)
                .ignoresSafeArea()
                .overlay(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
            HStack {
                windDetailView
                Spacer()
                compassView
            }
            .padding()
        }
        .overlay(alignment: .topLeading, content: {
            HStack {
                Image(systemName: "wind")
                Text("Wind")
            }
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, 8)
            .padding(.leading)
        })
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(height: 150)
        .padding()
    }
    
    private var windDetailView: some View {
        VStack(alignment: .leading, spacing: 0) {
//            Direction(Double(weather.current.windDirection10M)).rawValue.capitalized
           
                HStack {
                    Text("\(Int(weather.current.windSpeed10M))")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top, 4.0)
                    
                    VStack(alignment: .leading) {
                        Text("\(weather.currentUnits.windSpeed10M)")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.top, 4.0)
                        Text("Wind")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
            
            
            Rectangle()
                .fill(.white)
                .frame(height: 1.0)
                .padding(.vertical, 8.0)
            HStack {
                Text("\(Int(weather.current.windGusts10M))")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top, 4.0)
                VStack(alignment: .leading) {
                    Text("\(weather.currentUnits.windGusts10M)")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .padding(.top, 4.0)
                    Text("Gusts")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
                
            }
        }
        
    }
    
    private var compassView: some View {
        ZStack {
            compassBackground
            Arrow(insetAmount: 16)
                .strokeBorder(.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 30, height: 80)
                .rotationEffect(.degrees(Double(weather.current.windDirection10M)))

        }
    }
    
    private var compassBackground: some View {
        Circle()
            .fill(.blue.opacity(0.1))
            .frame(width: 100)
            .overlay(alignment: .top) {
                Text("N")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .padding(.top, 4.0)
            }
            .overlay(alignment: .leading) {
                Text("W")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .padding(.leading, 4.0)
            }
            .overlay(alignment: .trailing) {
                Text("E")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .padding(.trailing, 4.0)
            }
            .overlay(alignment: .bottom) {
                Text("S")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .padding(.bottom, 4.0)

            }
    }
}

#Preview {
    WindDirectionView(weather: .preview)
}

struct Arrow: InsettableShape {
    var insetAmount = 0.0

    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue}
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.height - insetAmount))
        path.addLine(to: CGPoint(x: rect.midX, y: insetAmount))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.height * 0.33))
        path.move(to: CGPoint(x: rect.midX, y: insetAmount))
        path.addLine(to: CGPoint(x: rect.width - insetAmount, y: rect.height * 0.33))

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

enum Direction: String, CaseIterable {
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
}

extension Direction: CustomStringConvertible  {
    init<D: BinaryFloatingPoint>(_ direction: D) {
        self =  Self.allCases[Int((direction.angle + 11.25).truncatingRemainder(dividingBy: 360)/22.5)]
    }
    var description: String { rawValue.uppercased() }
}

extension BinaryFloatingPoint {
    var angle: Self {
        (truncatingRemainder(dividingBy: 360) + 360)
            .truncatingRemainder(dividingBy: 360)
    }
    var direction: Direction { .init(self) }
}
