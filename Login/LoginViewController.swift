//
//  LoginViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/06.
//

import UIKit
import AuthenticationServices
import Alamofire

// MARK: - 로그인 뷰 컨트롤러
class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.initViews(self.view)
        loginView.btn_appleLogin.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
    }
}

// MARK: - 로그인 로직 처리
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        let userIdentifier = appleIDCredential.user
        var fullName = (appleIDCredential.fullName?.familyName ?? "") + (appleIDCredential.fullName?.givenName ?? "")
        
        let userDef = UserDefaults.standard
        userDef.set(userIdentifier, forKey: "userIdentifier")
        if (!fullName.isEmpty) {
            userDef.set(fullName, forKey: "userName")
            userDef.synchronize()
        }
        UserInfo.shared.userAccessToken = userIdentifier
        
//        if  let authorizationCode = appleIDCredential.authorizationCode,
//            let identityToken = appleIDCredential.identityToken,
//            let authString = String(data: authorizationCode, encoding: .utf8),
//            let tokenString = String(data: identityToken, encoding: .utf8) {
//            print("authorizationCode: \(authorizationCode)")
//            print("identityToken: \(identityToken)")
//            print("authString: \(authString)")
//            print("tokenString: \(tokenString)")
//        }
        
        self.postLogin(userIdentifier: userIdentifier, completion: { res in
            if (res) {
                let vc = MainTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            
            else {
                let vc = UINavigationController(rootViewController: SetNameViewController())
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        
        })
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.view.makeToast("로그인에 실패하였습니다.", duration: 2, position: .bottom)
    }
    
    // MARK: - todo: 로그인 처리
    @objc func didTapLoginBtn(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func decode(jwtToken jwt: String) -> [String: Any] {
        func base64UrlDecode(_ value: String) -> Data? {
            var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            
            let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
            let requiredLength = 4 * ceil(length / 4.0)
            let paddingLength = requiredLength - length
            if paddingLength > 0 {
                let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
                base64 = base64 + padding
            }
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }
        
        func decodeJWTPart(_ value: String) -> [String: Any]? {
            guard let bodyData = base64UrlDecode(value),
                  let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
                return nil
            }
            
            return payload
        }
        
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
}

// MARK: - 네트워크 용 extension
extension LoginViewController {
    func postLogin(userIdentifier: String, completion: @escaping (Bool) -> Void) {
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
}
