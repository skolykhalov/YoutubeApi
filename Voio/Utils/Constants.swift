//
//  Constants.swift
//  Voio
//
//  Created by Stas on 05.10.2022.
//

import Foundation

struct Constants {
    
    static let youtubeUrl = "https://www.googleapis.com/youtube/v3/"
    static let apiKey = "AIzaSyAQ1ap8Gk6OHkDYDsliQth384sfjcGed20"
    static let dataSource = ["UCEuOwB9vSL1oPKGNdONB4ig", "UCfM3zsQsOnfWNUppiycmBuw", "UCZU9T1ceaOgwfLRq7OKFU4Q", "UCi4EDAgjULwwNBHOg1aaCig"]
    static let firstPlaylistId = "PLlqZM4covn1G3hqrvNwpRy19pGDTYkUK6"
    static let secondPlaylistId = "PLTc0lwus22GYGulQrHGo04y3aTJNZSwC1"

    
}

struct Formatter {
    
    static let formatter: NumberFormatter = {
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         formatter.groupingSeparator = " "
         return formatter
     }()
    
    static func timeStringFor(seconds : Int) -> String {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.second, .minute, .hour]
      formatter.zeroFormattingBehavior = .pad
      let output = formatter.string(from: TimeInterval(seconds))!
      return seconds < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
    }
}
