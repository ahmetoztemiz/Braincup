//
//  SceneDelegate.swift
//  braincup
//
//  Created by Simon Schubert on 03.10.19.
//  Copyright © 2019 Simon Schubert. All rights reserved.
//

import UIKit
import SwiftUI
import shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AppInterface {
    
    var window: UIWindow?
    var appController: AppController?
    
    func showMainMenu(title: String, description: String, games: [GameType], instructions: @escaping (GameType) -> Void, score: @escaping (GameType) -> Void) {
        window?.rootViewController = UIHostingController(rootView: MainMenuView(title: title, description: description, games: games, instructions: instructions, score: score))
    }
    
    func showInstructions(title: String, description: String, start: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView:  InstructionsView(title: title, description: description, start: start, back: {self.appController?.start()}))
    }
    
    func showMentalCalculation(game: MentalCalculationGame, answer: @escaping (String) -> Void, next: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: MentalCalculationView(game: game, answer: { value in answer(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                next()
            }
        }, back: {self.appController?.start()}))
    }
    
    func showColorConfusion(game: ColorConfusionGame, answer: @escaping (String) -> Void, next: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: ColorConfusionView(game: game, answer: { value in answer(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                next()
            }
        }, back: {self.appController?.start()}))
    }
    
    func showSherlockCalculation(game: SherlockCalculationGame, answer: @escaping (String) -> Void, next: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: SherlockCalculationView(game: game, answer: { value in answer(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                next()
            }
        }, back: {self.appController?.start()}))
    }
    
    func showChainCalculation(game: ChainCalculationGame, answer: @escaping (String) -> Void, next: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: ChainCalculationView(game: game, answer: { value in answer(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                next()
            }
        }, back: {self.appController?.start()}))
    }
    
    func showHeightComparison(game: HeightComparisonGame, answer: @escaping (String) -> Void, next: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: HeightComparisonView(game: game, answer: { value in answer(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                next()
            }
        }, back: {self.appController?.start()}))
    }
    
    func showFractionCalculation(game: FractionCalculationGame, answer: @escaping (String) -> Void, next: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: FractionCalculationView(game: game, answer: { value in answer(value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                next()
            }
        }, back: {self.appController?.start()}))
    }
    
    func showCorrectAnswerFeedback() {
        window?.rootViewController = UIHostingController(rootView: CorrectAnswerView(back: {self.appController?.start()}))
    }
    
    func showWrongAnswerFeedback(solution: String) {
        window?.rootViewController = UIHostingController(rootView: WrongAnswerView(back: {self.appController?.start()}))
    }
    
    func showFinishFeedback(rank: String, newHighscore: Bool, plays: Int32, random: @escaping () -> Void) {
        window?.rootViewController = UIHostingController(rootView: FinishView(rank: rank, newHighscore: newHighscore, random: random, back: {self.appController?.start()}))
    }
    
    func showScoreboard(game: GameType, highscore: Int32, scores: [KotlinPair]) {
        window?.rootViewController = UIHostingController(rootView: ScoresView(game: game, highscore: highscore, scores: scores, back: {self.appController?.start()}))
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).


        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.makeKeyAndVisible()
        }

        if(appController == nil) {
            appController = AppController(app: self)
            appController?.start()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
