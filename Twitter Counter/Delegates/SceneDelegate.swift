//
//  SceneDelegate.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 21/09/2025.
//

import UIKit
import OAuthSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        // جِب التوكنز من UserDefaults
        let token = UserDefaults.standard.string(forKey: "twitterAccessToken")
        let secret = UserDefaults.standard.string(forKey: "twitterAccessSecret")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let token = token,
           let secret = secret,
           !token.isEmpty, !secret.isEmpty {
            // ✅ المستخدم مسجّل → روح للـ Home
            let homeVC = storyboard.instantiateViewController(
                withIdentifier: "TwitterHomeViewController"
            ) as! TwitterHomeViewController

            // مرر التوكنز للـ Client Singleton
            TwitterClient.shared.setUserTokens(token: token, secret: secret)

            window?.rootViewController = UINavigationController(rootViewController: homeVC)
        } else {
            // ❌ مفيش تسجيل → روح للـ Login
            let loginVC = storyboard.instantiateViewController(
                withIdentifier: "TwitterLoginVC"
            ) as! TwitterLoginVC

            window?.rootViewController = UINavigationController(rootViewController: loginVC)
        }

        window?.makeKeyAndVisible()
    }

    // دي عشان نمسك الـ callback اللي بيرجع من تويتر بعد الـ login
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            print("🔗 رجعنا من تويتر بالـ callback: \(url)")
            OAuthSwift.handle(url: url)
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

