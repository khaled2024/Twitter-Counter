//
//  TwitterClient.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//


import UIKit
import OAuthSwift

class TwitterClient {
    static let shared = TwitterClient()
    // MARK: - Properties
    private let apiKey: String
    private let apiSecret: String
    private let requestTokenUrl: String
    private let authorizeUrl: String
    private let accessTokenUrl: String
    
    var oauthswift: OAuth1Swift!
    
    private init() {
        self.apiKey = Bundle.main.object(forInfoDictionaryKey: AppConstants.TWITTER_API_KEY) as? String ?? ""
        self.apiSecret = Bundle.main.object(forInfoDictionaryKey: AppConstants.TWITTER_API_SECRET) as? String ?? ""
        self.requestTokenUrl = Bundle.main.object(forInfoDictionaryKey: AppConstants.TWITTER_REQUEST_TOKEN_URL) as? String ?? ""
        self.authorizeUrl = Bundle.main.object(forInfoDictionaryKey: AppConstants.TWITTER_AUTHORIZE_URL) as? String ?? ""
        self.accessTokenUrl = Bundle.main.object(forInfoDictionaryKey: AppConstants.TWITTER_ACCESS_TOKEN_URL) as? String ?? ""
        
        // Initialize OAuth
        oauthswift = OAuth1Swift(
            consumerKey:    apiKey,
            consumerSecret: apiSecret,
            requestTokenUrl: requestTokenUrl,
            authorizeUrl:    authorizeUrl,
            accessTokenUrl:  accessTokenUrl
        )
        
        // Debug
        print("apiKey: \(apiKey)")
        print("apiSecret: \(apiSecret)")
        print("requestTokenUrl: \(requestTokenUrl)")
        print("authorizeUrl: \(authorizeUrl)")
        print("accessTokenUrl: \(accessTokenUrl)")
    }
    
    
    // MARK: - Helper Methods
    func setUserTokens(token: String, secret: String) {
        oauthswift.client.credential.oauthToken = token
        oauthswift.client.credential.oauthTokenSecret = secret
    }
    
    // post tweet
    func postTweet(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = AppConstants.TwitterAPIUrl
        print("token:", oauthswift.client.credential.oauthToken)
        print("secret:", oauthswift.client.credential.oauthTokenSecret)
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
        oauthswift.authorize(withCallbackURL: AppConstants.URLSchemaCallback) { result in
            switch result {
            case .success(let (credential, _, _)):
                completion(true, credential)
                
                self.setUserTokens(token: credential.oauthToken, secret: credential.oauthTokenSecret)
                UserDefaults.standard.set(credential.oauthToken, forKey: AppConstants.TwitterAccessToken)
                UserDefaults.standard.set(credential.oauthTokenSecret, forKey: AppConstants.TwitterAccessSecret)
            case .failure:
                completion(false, OAuthSwiftCredential(consumerKey: "", consumerSecret: ""))
            }
        }
    }
    // twitterCount
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
