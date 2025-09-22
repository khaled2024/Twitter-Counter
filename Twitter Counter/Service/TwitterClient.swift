//
//  TwitterClient.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//


import UIKit
import OAuthSwift

class TwitterClient {

    let oauthswift = OAuth1Swift(
        consumerKey:    "V7Ir272NnswSCCCZMxilc8Tlr",      // API Key
        consumerSecret: "ibTcW3DbZE0iE9YK5L47Dj8gFjkOnA7WZDfA7lqCNfeydXQquT", // API Secret
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )
    
    init() {
        // دخّل الـ Access Tokens اللي عندك بالفعل
        oauthswift.client.credential.oauthToken = "1970086716716265472-erVpAfgdRhETyVNrjjLUXcQRsiBVnU"
        oauthswift.client.credential.oauthTokenSecret = "EObzMF7qWpqW6m6nhAEOMEt4iUtgGVSSLVwg8c3d7GtYl"
    }

    func postTweet(text: String,completion: @escaping (_ json:String)->Void ) {
        let url = "https://api.twitter.com/2/tweets"
        oauthswift.client.post(
            url,
            parameters: ["text": text],
            headers: ["Content-Type": "application/json"]
        ) { result in
            switch result {
            case .success(let response):
                if let json = response.string {
                    completion(json)
                   
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func twitterCount(_ text: String) -> Int {
        var count = 0
        let regex = try! NSRegularExpression(pattern: "https?://\\S+")
        
        let nsText = text as NSString
        let matches = regex.matches(in: text, range: NSRange(location: 0, length: nsText.length))
        var covered = Set<Int>()
        for match in matches {
            count += 23
            for i in match.range.location..<match.range.location+match.range.length {
                covered.insert(i)
            }
        }
        
        for (i, scalar) in text.unicodeScalars.enumerated() {
            if covered.contains(i) { continue }
            if scalar.value > 0xFFFF {
                count += 2
            } else {
                count += 1
            }
        }
        
        return count
    }
    
    


}
