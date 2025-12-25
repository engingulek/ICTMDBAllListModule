//
//  SwiftUIView.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 24.12.2025.
//

import SwiftUI
import ICTMDBViewKit
struct TvShowItem: View {
    let item:TVShowPresentation
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                AppImage(
                    source: .remote(url: item.mainPoster, type: .main))
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .clipped()
                
                AppText(text: item.flag, style: .cardSubTitle)
                    .padding([.top, .trailing], 5)
            }.overlay(
                RatingView(score: item.rating, type: .airingToday)
                    .padding([.bottom, .trailing], 8),
                alignment: .bottomTrailing
            )
            AppText(text: item.title, style: .cardTitle)
                .padding()
            
            Spacer(minLength: 0)
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 0.5)
        )
    }
}
