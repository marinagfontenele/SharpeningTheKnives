//
//  SceneDelegade.swift
//  MyApp
//
//  Created by Marina Gomes Fontenele on 16/11/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ContentView()
        self.window = window
        window.makeKeyAndVisible()
    }
}
