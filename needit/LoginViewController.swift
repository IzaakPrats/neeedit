//
//  LoginViewController.swift
//  needit
//
//  Created by Izaak Prats on 10/14/15.
//  Copyright © 2015 IJVP. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import FBSDKLoginKit
import Accounts
import Social
import Google

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    // UI Outlets
    
    @IBOutlet weak var emailEditText: UITextField!
    
    @IBOutlet weak var passwordEditText: UITextField!
    
    // UI Actions
    
    @IBAction func facebookButtonClicked() {
        loginWithFacebook()
    }
    
    @IBAction func twitterButtonClicked() {
        loginWithTwitter()
    }
    
    @IBAction func googleButtonClicked() {
         GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func dismissButtonClicked() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Class Vars
    let ref = FirebaseUtils.singleton.firebaseRef
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Google Sign-In */
        // Setup delegates
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Attempt to sign in silently, this will succeed if
        // the user has recently been authenticated
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCurrentUser(user: User) {
        
    }
    
    func goToDelivererMenu() {
        
    }
    
    func createUser(authData: FAuthData) {
        let id = authData.uid
        let name = authData.providerData["displayName"] as! String
        let profileImageURL = authData.providerData["profileImageURL"] as! String
        var email = authData.providerData["email"] as? String
        
        /* TODO */
    }
    
    func loginWithFacebook() {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                self.ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            print("Login failed. \(error)")
                        } else {
                            print("Logged in! \(authData)")
                            FirebaseUtils.singleton.getUserById(authData.uid, onComplete: {
                                user in
                                
                                if (user == nil) {
                                    self.createUser(authData)
                                } else {
                                    self.setCurrentUser(user!)
                                    
                                    if (user!.type == .Deliverer) {
                                        self.goToDelivererMenu()
                                    } else {
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    }
                                }
                            })
                        }
                })
            }
        })
    }

    func loginWithTwitter() {
        let twitterAuthHelper = TwitterAuthHelper(firebaseRef: self.ref, apiKey:"WFFEu2mRncphOsIZ09VbdjnLM")
        
        twitterAuthHelper.selectTwitterAccountWithCallback { error, accounts in
            if error != nil {
                // Error retrieving Twitter accounts
            } else if accounts.count > 1 {
                // Select an account. Here we pick the first one for simplicity
                let account = accounts[0] as? ACAccount
                twitterAuthHelper.authenticateAccount(account, withCallback: { error, authData in
                    if error != nil {
                        // Error authenticating account
                        print("Login failed. \(error)")
                    } else {
                        // User logged in!
                        print("Logged in! \(authData)")
                        FirebaseUtils.singleton.getUserById(authData.uid, onComplete: {
                            user in
                            
                            if (user == nil) {
                                self.createUser(authData)
                            } else {
                                
                                self.setCurrentUser(user!)
                                if (user!.type == .Deliverer) {
                                    self.goToDelivererMenu()
                                } else {
                                    self.dismissViewControllerAnimated(true, completion: nil)
                                }
                            }
                        })
                    }
                })
            }
        }
    }
    
    // Implement the required GIDSignInDelegate methods
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Auth with Firebase
                ref.authWithOAuthProvider("google", token: user.authentication.accessToken, withCompletionBlock: { (error, authData) in
                    if error != nil {
                        // Error authenticating account
                        print("Login failed. \(error)")
                    } else {
                        // User logged in!
                        print("Logged in! \(authData)")
                        FirebaseUtils.singleton.getUserById(authData.uid, onComplete: {
                            user in
                            
                            if (user == nil) {
                                self.createUser(authData)
                                
                            } else {
                                self.setCurrentUser(user!)
                                if (user!.type == .Deliverer) {
                                    self.goToDelivererMenu()
                                } else {
                                   self.dismissViewControllerAnimated(true, completion: nil)
                                }
                            }
                        })
                    }
                })
            } else {
                // Don't assert this error it is commonly returned as nil
                print("\(error.localizedDescription)")
            }
    }
    
    // Implement the required GIDSignInDelegate methods
    // Unauth when disconnected from Google
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            ref.unauth();
    }
}
