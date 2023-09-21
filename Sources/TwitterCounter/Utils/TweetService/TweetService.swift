//
//  TweetService.swift
//  Twitter Counter Sample App
//
//  Created by Mah on 21/09/2023.
//

import UIKit

protocol PTweetService {
    func tweet(text: String)
}

class TweetService: PTweetService {
    func tweet(text: String) {
        guard let tweet = text
            .addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else {
            return
        }
        
        guard let appUrl = URL(string: "twitter://post?message=\(tweet)") else {
            return
        }
        
  
        let application = UIApplication.shared
        
        if application.canOpenURL(appUrl) {
            application.open(appUrl)
        } else {
            guard let webUrl = URL(string: "https://twitter.com/intent/tweet?text=\(tweet)") else {
                return
            }
            
            application.open(webUrl)
        }
    }
}
