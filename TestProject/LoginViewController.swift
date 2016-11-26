//
//  LoginViewController.swift
//  TestProject
//
//  Created by Roma Balboa on 16.11.16.
//  Copyright © 2016 Roman Romanenko. All rights reserved.
//

import UIKit

fileprivate struct Login {
    struct ParseFacebookResponse {
        static let email = "email"
        static let noEmail = "Set your \(email) in settings"
        static let name = "name"
        static let noName = "Set your \(name) in settings"
        static let birthday = "birthday"
        static let noBirthday = "Set your \(birthday) in settings"
        
        static let picture = "picture.type(normal)"
    }
    
    static let withFacebookViewController = "goToLoginWithFacebookViewController"
}

fileprivate struct FacebookManager {
    static let permissions = ["public_profile", "email"]
    static let path = "me"
    static let contains = "email"
    static let parameters = ["fields": "id, name, first_name, last_name, picture.type(normal), email"]
}

fileprivate struct RegisterManualy {
    static let width = CGFloat(1)
    static let color = Colors.mint.cgColor
}

class LoginViewController: TestProjectViewController {
    
    @IBOutlet var registerManualy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewConstructor.addBorderToButton(button: registerManualy, width: RegisterManualy.width, color: RegisterManualy.color)
        ViewConstructor.add(shadowTo: registerManualy)
    }

    @IBAction func connectWithFacebookAction(_ sender: Any) {
        self.loginWithFacebook()
//        self.performSegue(withIdentifier: Login.withFacebookViewController, sender: self)
    }
    
}

extension LoginViewController {
    
    func loginWithFacebook() {
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = .systemAccount
        loginManager.logIn(withReadPermissions: FacebookManager.permissions, from: self) {(result, error) in
            
            if error == nil {
                if (result?.isCancelled)! {
                    return
                }
            }

//MARK:- OAuth2 (accessToken and userID if needed)
            
            _ = FBSDKAccessToken.current().tokenString
            _ = FBSDKAccessToken.current().userID
            
            if error == nil {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if (fbloginresult.grantedPermissions.contains(FacebookManager.contains)) {
                        self.getFBUserData()
                        self.performSegue(withIdentifier: Login.withFacebookViewController, sender: self)
                    }
                }
            } else {
                //else
            }
        }
    }
    
    func getFBUserData() {
        if((FBSDKAccessToken.current()) != nil) {
            let path = FacebookManager.path
            let parameters = FacebookManager.parameters
            
            FBSDKGraphRequest(graphPath: path, parameters: parameters).start(completionHandler: { (connection, response, error) in
                if error == nil {
                    let parseResult = response! as! [String: Any]
                    self.dataToFacebookFieldsView(parameter: parseResult)
                    self.dataToFriendsView(parameter: parseResult)
                } else {
                
                }
            })
        }
    }
    
    func dataToFacebookFieldsView(parameter parseResult: [String: Any]) {
        
//        print("parseResult: ", parseResult)
//        print("----------------")
//        let getPic = parseResult["picture"] as! [String : Any]
//        let data = getPic["data"] as! [String : Any]
//        let picture = data["url"] ?? "pic"
//        print("parseResult: ", picture)
        
        
        let email = Login.ParseFacebookResponse.email
        let noEmail = Login.ParseFacebookResponse.noEmail
        
        let name = Login.ParseFacebookResponse.name
        let noName = Login.ParseFacebookResponse.noName
        
        let birthday = Login.ParseFacebookResponse.birthday
        let noBirthday = Login.ParseFacebookResponse.noBirthday
        
        let userEmail = String(describing: parseResult[email] ?? noEmail)
        let userName = String(describing: parseResult[name] ?? noName)
        let userBirthday =  String(describing: parseResult[birthday] ?? noBirthday)
        
        let dataToFacebookFieldsView = [userEmail, userName, userBirthday]
        
        NotificationCenter.default.post(name: Constants.dataToFacebookFieldsView, object: dataToFacebookFieldsView)
        
        //print(parseResult)
    }
    
    func dataToFriendsView(parameter parseResult: [String: Any]) {
        let pictureRequest = parseResult["picture"] as! [String : Any]
        let data = pictureRequest["data"] as! [AnyHashable : Any]
        let picture = data["url"] ?? 0

        let name = Login.ParseFacebookResponse.name
        let noName = Login.ParseFacebookResponse.noName
        
        let userName = String(describing: parseResult[name] ?? noName)
        let userPicture = picture
        

        
        let dataToFriendsView = [userName, userPicture]
        
        print("let dataToFriendsView = [userLastName, userPicture]: ", dataToFriendsView)
        
        NotificationCenter.default.post(name: Constants.dataToFriendsView, object: dataToFriendsView)
        
        //print(parseResult)
    }

}
