//
//  ChartView.swift
//  CryptoChecker (iOS)
//
//  Created by YES 2011 Limited on 10/03/2022.
//

import SwiftUI

struct ChartView: View {

    @ObservedObject var viewModel: CoinDetailViewModel

    var body: some View {
        chart
    }
}

extension ChartView {

    var chart: some View {
        GeometryReader { reader in
            chartValues(reader: reader)
            xAxisGridLines(reader: reader)
            yAxisGridLines(reader: reader)
            gridBorder(reader: reader, edge: .leading)
            gridBorder(reader: reader, edge: .bottom)
        }
    }

    func chartValues(reader: GeometryProxy) -> some View {
        let firstPrice = viewModel.coinPrices.first?.price ?? 0
        let lastPrice = viewModel.coinPrices.last?.price ?? 0
        return ForEach(viewModel.coinPrices.indices.reversed(), id: \.self) { priceIdx in
            let strokeColor = lastPrice < firstPrice ? Color.red : Color.green
            Path { path in
                if viewModel.coinPrices.count > 1 {
                    let chartItemWidth = reader.size.width / CGFloat(viewModel.coinPrices.count)
                    let chartHeight = reader.size.height / viewModel.priceRange
                    let chartOffset = CGFloat(priceIdx) * chartItemWidth
                    let priceFrom = (viewModel.coinPrices[priceIdx].price - viewModel.minPrice) * chartHeight
                    path.move(to: CGPoint(x: chartOffset, y: reader.size.height - priceFrom))
                    if (priceIdx+1) < viewModel.coinPrices.count {
                        let priceTo = (viewModel.coinPrices[priceIdx+1].price - viewModel.minPrice) * chartHeight
                        let chartOffset = CGFloat(priceIdx+1) * chartItemWidth
                        path.addLine(to: CGPoint(x: chartOffset, y: reader.size.height - priceTo))
                    }
                }
            }
            .stroke(strokeColor, lineWidth: 1)
        }
    }

    func xAxisGridLines(reader: GeometryProxy) -> some View {
        let gridLineCnt = 5
        return ForEach(0..<gridLineCnt, id: \.self) { idx in
            Path { path in
                let yAxis = (reader.size.height / CGFloat(gridLineCnt)) * CGFloat(idx)
                path.move(to: CGPoint(x: 0, y: yAxis))
                path.addLine(to: CGPoint(x: reader.size.width, y: yAxis))
            }
            .stroke(gridLineColor)
        }
    }

    func yAxisGridLines(reader: GeometryProxy) -> some View {
        let gridLineCnt = 6
        return ForEach(0..<gridLineCnt, id: \.self) { idx in
            Path { path in
                let xAxis = (reader.size.width / CGFloat(gridLineCnt)) * CGFloat(idx)
                path.move(to: CGPoint(x: xAxis, y: 0))
                path.addLine(to: CGPoint(x: xAxis, y: reader.size.height))
            }.stroke(gridLineColor)
        }
    }

    func gridBorder(reader: GeometryProxy, edge: Edge) -> some View {
        Path { path in

            let xFrom = 0.0
            var yFrom = 0.0
            var xTo = 0.0
            var yTo = 0.0

            switch edge {
            case .leading:
                yTo = reader.size.height
            case .bottom:
                yFrom = reader.size.height
                xTo = reader.size.width
                yTo = reader.size.height
            default:
                break
            }

            path.move(to: CGPoint(x: xFrom, y: yFrom))
            path.addLine(to: CGPoint(x: xTo, y: yTo))
        }.stroke(gridBorderColor)
    }

    var gridLineColor: Color {
        Color.black.opacity(0.1)
    }

    var gridBorderColor: Color {
        Color.black.opacity(0.8)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(viewModel: CoinDetailViewModel())
    }
}
