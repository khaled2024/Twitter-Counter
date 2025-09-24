//
//  SceneDelegate.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 21/09/2025.
//

import UIKit
import OAuthSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Vars
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        let token = UserDefaults.standard.string(forKey: AppConstants.TwitterAccessToken)
        let secret = UserDefaults.standard.string(forKey: AppConstants.TwitterAccessSecret)
        
        
        
        if let token = token,
           let secret = secret,
           !token.isEmpty, !secret.isEmpty {
            goToHome(token: token, secret: secret)
        } else {
            goToLogin()
        }
        window?.makeKeyAndVisible()
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            OAuthSwift.handle(url: url)
        }
    }
    // MARK: - Private Functions
    private func goToHome(token: String , secret: String){
        let homeVC = storyboard.instantiateViewController(
            withIdentifier: "TwitterHomeViewController"
        ) as! TwitterHomeViewController
        
        TwitterClient.shared.setUserTokens(token: token, secret: secret)
        
        window?.rootViewController = UINavigationController(rootViewController: homeVC)
    }
    private func goToLogin(){
        let loginVC = storyboard.instantiateViewController(
            withIdentifier: "TwitterLoginVC"
        ) as! TwitterLoginVC
        
        window?.rootViewController = UINavigationController(rootViewController: loginVC)
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

