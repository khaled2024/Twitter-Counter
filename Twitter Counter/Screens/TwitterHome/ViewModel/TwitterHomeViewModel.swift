//
//  TwitterHomeViewModel.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//

import UIKit
class TwitterHomeViewModel{
    private let client = TwitterClient.shared
      
    private let twitterLimit = 280
    
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
        client.postTweet(text: text) { result in
            completion(result)
            print(result)
        }
    }
    func logout(){
        UserDefaults.standard.removeObject(forKey: "twitterAccessToken")
        UserDefaults.standard.removeObject(forKey: "twitterAccessSecret")
        TwitterClient.shared.setUserTokens(token: "", secret: "")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "TwitterLoginVC") as! TwitterLoginVC
        let nav = UINavigationController(rootViewController: loginVC)
        
        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = nav
        }
    }
}
