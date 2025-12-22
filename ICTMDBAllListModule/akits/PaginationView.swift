//
//  PaginationView.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 22.12.2025.
//
import SwiftUI
struct PaginationView: View {
    let currentPage: Int
        let totalPages: Int
        let prevAction: () -> Void
        let nextAction: () -> Void
        
        var body: some View {
            HStack(spacing: 25) { // Oklar arası boşluk
                // Sol Ok
                Button(action: prevAction) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(currentPage > 1 ? .black : .gray.opacity(0.5))
                }
                .disabled(currentPage <= 1)
                
                // Mevcut Durum Bilgisi (Opsiyonel: 4 / 274 gibi)
                Text("\(currentPage) / \(totalPages)")
                    .font(.system(size: 16, weight: .semibold))
                    .monospacedDigit() // Rakamlar değişirken genişlik oynamasın diye
                
                // Sağ Ok
                Button(action: nextAction) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(currentPage < totalPages ? .black : .gray.opacity(0.5))
                }
                .disabled(currentPage >= totalPages)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .clipShape(Capsule()) // Tam oval yapı
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
}
