//
//  RatingView.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI

// MARK: - RatingViewType
public enum RatingViewType {
    case popular
    case airingToday
    case detail
    
    // Tip bazlı konfigürasyonları enum içinde tutmak kod kirliliğini önler
    var size: CGFloat {
        switch self {
        case .popular: return 36
        case .airingToday: return 40
        case .detail: return 48
        }
    }
    
    var font: Font {
        switch self {
        case .popular: return .system(size: 13, weight: .bold)
        case .airingToday: return .system(size: 15, weight: .semibold)
        case .detail: return .system(size: 16, weight: .bold)
        }
    }
    
    var textColor: Color {
        switch self {
        case .popular: return .white
        case .airingToday, .detail: return .primary // SwiftUI'da .black yerine .primary kullanmak Dark Mode uyumu sağlar
        }
    }
}

// MARK: - RatingView
public struct RatingView: View {
    let score: Double
    let type: RatingViewType
    
    private var scoreColor: Color {
        switch score {
        case 0.0..<6.0: return .red
        case 6.0..<8.0: return .orange
        case 8.0...10.0: return .green
        default: return .gray
        }
    }
    
    public var body: some View {
        ZStack {
            // Arka Plan Rengi (Sadece Airing Today için beyaz)
            if type == .airingToday {
                Circle()
                    .fill(Color.white)
            }
            
            // Arka plandaki sönük halka (Track)
            Circle()
                .stroke(scoreColor.opacity(0.2), lineWidth: 3)
            
            // Puanı gösteren ilerleme halkası
            Circle()
                .trim(from: 0, to: CGFloat(score / 10.0))
                .stroke(scoreColor, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            // Puan metni
            Text(String(format: "%.1f", score))
                .font(type.font)
                .foregroundColor(type.textColor)
        }
        .frame(width: type.size, height: type.size)
        // Eğer arka plan beyaz ise, halkanın dışarı taşmaması için gölge eklenebilir
        .shadow(color: type == .airingToday ? .black.opacity(0.1) : .clear, radius: 2)
    }
}
