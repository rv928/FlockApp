//
//  LoginViewController.swift
//  FlockApp
//
//  Created by Admin on 17/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    // MARK:- IBOutlet Properties
    
    @IBOutlet weak var emailTextField: BorderTextField!
    @IBOutlet weak var passwordTextField: BorderTextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!

    
    // MARK:- Properties
    
    private var viewModel = LoginVMModel(loginFetcher: FeedWSManager())
    var userModel:[LoginUser]?
    
   
    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLoginView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     This method will prepare LoginView.
     */
    private func prepareLoginView() {
        self.emailTextField.text = "hari2@spotflock.com"
        self.passwordTextField.text = "akjshdlaks"
    }
    
    // MARK:- Button Action Methods
   
    @IBAction func loginButtonClicked(_ sender: Any) {

        let trimmedEmail = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        let trimmedPass = passwordTextField.text?.trimmingCharacters(in: .whitespaces)

        if (trimmedEmail?.isEmpty)! {
            emailTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.enterEmail, title: APP_NAME)
            return
        }
        if (trimmedPass?.isEmpty)! {
            passwordTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.enterPassword, title: APP_NAME)
            return
        }
        if !(trimmedEmail?.isEmail)! {
            AlertManager().showAlert(withMessage: MessageConstant.validEmail, title: APP_NAME)
            return
        }
        var loginDict:Dictionary<String,Any> = Dictionary()
        loginDict[email] = trimmedEmail
        loginDict[password] = trimmedPass
        
        viewModel.loginWSCall(inputDict: loginDict) { (objUser) in
           // print(objUser?.name)
            DispatchQueue.main.async {
                self.navigateToFeedListWithUser()
            }
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK:- Navigation Push

extension LoginViewController {
    
    private func navigateToFeedListWithUser() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FeedListViewController") as! FeedListViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
