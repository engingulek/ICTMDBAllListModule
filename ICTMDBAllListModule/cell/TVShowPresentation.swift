//
//  TVShowPresentation.swift
//  ICTMDBAllListModule
//
//  Created by Engin Gülek on 12.11.2025.
//
import ICTMDBViewKit
struct TVShowPresentation: Equatable {
    var id:Int?
    var title: String
    var flag: String
    var rating: Double
    var mainPoster:String
    
    init(
        id:Int,
        title: String,
        flag: String,
        rating: Double,
        mainPoster:String
    ) {
        self.id = id
        self.title = title
        self.flag = flag
        self.rating = rating
     
        self.mainPoster = mainPoster
    }
}


extension TVShowPresentation {
    public init(tvShow: TvShow) {
        self.id = tvShow.id
        self.title = tvShow.name ?? ""
        self.flag = LanguageFlags.flag(for: tvShow.originalLanguage ?? "")
        self.rating = tvShow.voteAverage ?? 0.0
        self.mainPoster = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")"
    }
}
