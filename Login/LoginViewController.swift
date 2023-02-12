//
//  LoginViewController.swift
//  BookMark
//
//  Created by JOSUEYEON on 2023/02/06.
//

import UIKit
import AuthenticationServices

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
        var email = appleIDCredential.email ?? ""
        
        if email.isEmpty {
            if let tokenString = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) {
                email = decode(jwtToken: tokenString)["email"] as? String ?? ""
            }
        }
        
        if fullName.isEmpty {
            if let tokenString = String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8) {
                fullName = decode(jwtToken: tokenString)["fullName"] as? String ?? ""
            }
        }
        
        print("fullname: \(fullName)")
        print("email: \(email)")
        
        let userDef = UserDefaults.standard
        userDef.set(userIdentifier, forKey: "userIdentifier")
        if (!fullName.isEmpty) {
            userDef.set(fullName, forKey: "userName")
            userDef.set(email, forKey: "userEmail")
        }
        userDef.synchronize()
        
        if  let authorizationCode = appleIDCredential.authorizationCode,
            let identityToken = appleIDCredential.identityToken,
            let authString = String(data: authorizationCode, encoding: .utf8),
            let tokenString = String(data: identityToken, encoding: .utf8) {
            print("authorizationCode: \(authorizationCode)")
            print("identityToken: \(identityToken)")
            print("authString: \(authString)")
            print("tokenString: \(tokenString)")
        }
        
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.view.makeToast("로그인에 실패하였습니다.", duration: 2, position: .bottom)
    }
    
    // MARK: - todo: 로그인 처리
    @objc func didTapLoginBtn(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
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
