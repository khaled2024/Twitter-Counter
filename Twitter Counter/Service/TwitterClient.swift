//
//  TwitterClient.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//


import UIKit
import OAuthSwift

class TwitterClient {
    let oauthswift: OAuth1Swift
    init() {
        oauthswift = OAuth1Swift(
            consumerKey:    "V7Ir272NnswSCCCZMxilc8Tlr",      // API Key
            consumerSecret: "ibTcW3DbZE0iE9YK5L47Dj8gFjkOnA7WZDfA7lqCNfeydXQquT", // API Secret
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
    }
    func setUserTokens(token: String, secret: String) {
        oauthswift.client.credential.oauthToken = token
        oauthswift.client.credential.oauthTokenSecret = secret
    }
    
    // post tweet
    func postTweet(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://api.twitter.com/2/tweets"
        print("🔑 token:", oauthswift.client.credential.oauthToken)
        print("🔑 secret:", oauthswift.client.credential.oauthTokenSecret)
        oauthswift.client.post(
            url,
            parameters: ["text": text],
            headers: ["Content-Type": "application/json"]
        ) { result in
            switch result {
            case .success(let response):
                if let json = response.string {
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "TwitterClient",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Empty response"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // login
    func login(completion: @escaping (Bool, OAuthSwiftCredential) -> Void) {
        
        oauthswift.authorize(withCallbackURL: "twittercounter://auth/callback") { result in
            switch result {
            case .success(let (credential, _, _)):
                completion(true, credential)
                self.setUserTokens(token: credential.oauthToken, secret: credential.oauthTokenSecret)
            case .failure:
                completion(false, OAuthSwiftCredential(consumerKey: "", consumerSecret: ""))
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
