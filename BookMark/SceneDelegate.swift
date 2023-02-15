//
//  SceneDelegate.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/01/06.
//

import UIKit
import Alamofire
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        guard let _ = UserDefaults.standard.string(forKey: "Tutorial") else {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = TutorialViewController()
            self.window = window
            window.makeKeyAndVisible()
            return
        }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        if let userIdentifier = UserDefaults.standard.string(forKey: "userIdentifier") {
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    self.autoAppleLogin(completion: { res in
                        if (res) {
                            DispatchQueue.main.async {
                                let window = UIWindow(windowScene: windowScene)
                                window.rootViewController = MainTabBarController()
                                self.window = window
                                window.makeKeyAndVisible()
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                let window = UIWindow(windowScene: windowScene)
                                window.rootViewController = LoginViewController()
                                self.window = window
                                window.makeKeyAndVisible()
                            }
                        }
                    })
                    
                default:
                    DispatchQueue.main.async {
                        let window = UIWindow(windowScene: windowScene)
                        window.rootViewController = LoginViewController()
                        self.window = window
                        window.makeKeyAndVisible()
                    }
                }
            }
        }
        else {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = LoginViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
        
        NotificationCenter.default.addObserver(forName: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil, queue: nil) { (Notification) in
            DispatchQueue.main.async {
                
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = LoginViewController()
                self.window = window
                window.makeKeyAndVisible()
            }
        }
    }
    
    private func autoAppleLogin(completion: @escaping (Bool) -> Void) {
        let userDef = UserDefaults.standard
        guard let userIdentifier = userDef.string(forKey: "userIdentifier") else {
            completion(false)
            return
        }
        UserInfo.shared.userAccessToken = userIdentifier
        
        self.postLogin(userIdentifier: userIdentifier, completion: { res in
            if (res) {
                if let name = userDef.string(forKey: "userNickName"), let msg = userDef.string(forKey: "userMessage"), let goal = userDef.string(forKey: "userGoal") {
                    UserInfo.shared.userNickName = name
                    UserInfo.shared.userMessage = msg
                    UserInfo.shared.userGoal = Int(goal) ?? 0
                }
                completion(true)
            }
            
            else {
                completion(false)
            }
            
        })
    }
    
    private func postLogin(userIdentifier: String, completion: @escaping (Bool) -> Void) {
        let params: Parameters = ["access_token": userIdentifier]
        let baseUrl = "https://port-0-bookmark-oneliner-luj2cldx5nm16.sel3.cloudtype.app"
        let URL = baseUrl + "/login"
        let datarequest = AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default).validate()
        
        datarequest.responseData(completionHandler: { response in
            switch response.result {
            case .success:
                guard let value = response.value else {return}
                guard let _ = response.response?.statusCode else {return}
                
                let decoder = JSONDecoder()
                guard let decodedData = try? decoder.decode(LoginResponse.self, from: value) else {
                    return
                }
                if (decodedData.message == " 기등록된 유저 입니다.") {
                    if let id = decodedData.userId?[0].userID {
                        print("user ID: \(id)")
                        UserInfo.shared.userID = id
                        completion(true)
                    }
                }
                else if (decodedData.message == " 등록되지 않은 유저입니다. ") {
                    completion(false)
                }
                else {
                    print("no message")
                }
                
                
            case .failure(let e):
                print(e)
            }
            
        })
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
