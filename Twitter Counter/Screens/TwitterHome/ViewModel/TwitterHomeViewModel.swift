//
//  TwitterHomeViewModel.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//

import UIKit
class TwitterHomeViewModel{
    
    private let twitterLimit = 280
    private let client = TwitterClient()
    
    func countCharacters(_ text: String) -> (count: Int, remaining: Int, isValid: Bool) {
        let count = client.twitterCount(text)
        let remaining = twitterLimit - count
        let isValid = count <= twitterLimit
        return (count, remaining, isValid)
    }
    
    func copyText(_ text: String) {
        UIPasteboard.general.string = text
    }
    
    func clearText() -> String {
        return ""
    }
    
    func postTweet(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        client.postTweet(text: text) { json in
            completion(.success(json))
        }
    }
}
