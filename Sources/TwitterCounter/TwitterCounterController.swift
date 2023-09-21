//
//  TwitterCounterController.swift
//  Twitter Counter Sample App
//
//  Created by Mah on 21/09/2023.
//

import Foundation
import UIKit

protocol PTwitterCounterController {
    func getTweetPlaceHolder() -> String
    func shouldEnableBtns() -> Bool
    func updateCharactersCount(_ text: String)
    func getCharactersTypedContent() -> String
    func getCharactersRemainingContent() -> String
    func copyText(_ text: String)
    func postTweet(_ text: String)
}

class TwitterCounterController: PTwitterCounterController {
    
    private let maxCharacters = 280
    private var charactersCount = 0
    private let tweetPlaceHolder = "Start typing! You can enter up to 280 characters"
    private let tweetService: PTweetService
    
    init(tweetService: PTweetService = TweetService()) {
        self.tweetService = tweetService
    }
    
    func getTweetPlaceHolder() -> String {
        return tweetPlaceHolder
    }
    
    func shouldEnableBtns() -> Bool {
        return charactersCount > 0
    }
    
    // Using as NSString here to count characters like Twitter does
    // NSString out of the box handles Unicode characters and surrogate pairs 
    func updateCharactersCount(_ text: String) {
        charactersCount = (text as NSString).length
    }
    
    func getCharactersTypedContent() -> String {
        return "\(charactersCount) / \(maxCharacters)"
    }
    
    func getCharactersRemainingContent() -> String {
        return "\(maxCharacters - charactersCount)"
    }
    
    func copyText(_ text: String) {
        UIPasteboard.general.setValue(text, forPasteboardType: "public.plain-text")
    }
    
    func postTweet(_ text: String) {
        tweetService.tweet(text: text)
    }
}
