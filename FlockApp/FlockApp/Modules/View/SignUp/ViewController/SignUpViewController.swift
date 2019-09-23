//
//  SignUpViewController.swift
//  FlockApp
//
//  Created by Admin on 18/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
let PASSWORD_LENGTH = 8

// MARK: GenderType

enum GenderType : String {
    case Select  = "Select"
    case Male    = "Male"
    case Female  = "Female"
    case Other   = "Other"
}
class SignUpViewController: UIViewController {

    // MARK:- IBOutlet Properties
    
    @IBOutlet weak var firstNameTextField: BorderTextField!
    @IBOutlet weak var lastNameTextField: BorderTextField!
    @IBOutlet weak var emailTextField: BorderTextField!
    @IBOutlet weak var passwordTextField: BorderTextField!
    @IBOutlet weak var conPassTextField: BorderTextField!
    @IBOutlet weak var contactNoTextField: BorderTextField!
    
    @IBOutlet weak var maleButton: BoxButton!
    @IBOutlet weak var femaleButton: BoxButton!
    @IBOutlet weak var otherButton: BoxButton!
    
    // MARK:- Properties
    private var viewModel = SignUpVMModel(signupFetcher: FeedWSManager())
    private var genderType:String = GenderType.Select.rawValue

    
    // MARK:- ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     * This method will setup NavigationBar
     */
    func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor(hexColor: UIConstant.appColor)!
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hexColor: UIConstant.navTextColor)!]
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named:UIConstant.Images.backIcon), for: .normal)
        button.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.title = "SignUp"
    }
    
    @objc func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    
    func validateFields(isTextField:Bool) -> Bool {
        
        let trimmedFirstName = firstNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let trimmedLastName = lastNameTextField.text?.trimmingCharacters(in: .whitespaces)
        let trimmedEmail = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        let trimmedPass = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        let trimmedConPass = conPassTextField.text?.trimmingCharacters(in: .whitespaces)
        let trimmedContactNo = contactNoTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if (trimmedFirstName?.isEmpty)! {
            AlertManager().showAlert(withMessage: MessageConstant.enterFirstName, title: APP_NAME)
            return false
        }
        if (trimmedLastName?.isEmpty)! {
            AlertManager().showAlert(withMessage: MessageConstant.enterLastName, title: APP_NAME)
            return false
        }
        if (trimmedEmail?.isEmpty)! {
            emailTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.enterEmail, title: APP_NAME)
            return false
        }
        if !(emailTextField.text?.isEmail)! {
            AlertManager().showAlert(withMessage: MessageConstant.validEmail, title: APP_NAME)
            return false
        }
        if (trimmedPass?.isEmpty)! {
            passwordTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.enterPassword, title: APP_NAME)
            return false
        }
        if (trimmedPass?.count ?? 0) < PASSWORD_LENGTH {
            passwordTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.validPasswordLength, title: APP_NAME)
            return false
        }
        if (trimmedConPass?.isEmpty)! {
            conPassTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.enterConfirmPassword, title: APP_NAME)
            return false
        }
        if (trimmedConPass?.count ?? 0) < PASSWORD_LENGTH {
            conPassTextField.text = "";
            AlertManager().showAlert(withMessage: MessageConstant.validPasswordLength, title: APP_NAME)
            return false
        }
        if trimmedPass != trimmedConPass {
            AlertManager().showAlert(withMessage: MessageConstant.notMatch, title: APP_NAME)
            return false
        }
        if (trimmedContactNo?.isEmpty)! {
            AlertManager().showAlert(withMessage: MessageConstant.enterContactNo, title: APP_NAME)
            return false
        }
        if genderType == GenderType.Select.rawValue {
            AlertManager().showAlert(withMessage: MessageConstant.enterGender, title: APP_NAME)
            return false
        }
        return true
    }
    
    // MARK:- Button Action Methods
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
       
        if validateFields(isTextField: true) == true {
            var signupDict:Dictionary<String,Any> = Dictionary()
            signupDict[name] = firstNameTextField.text! + " " + lastNameTextField.text!
            signupDict[email] = emailTextField.text!
            signupDict[password] = passwordTextField.text!
            signupDict[password_confirmation] = conPassTextField.text!
            signupDict[mobile] = contactNoTextField.text!
            signupDict[gender] = genderType
            
            viewModel.signupWSCall(inputDict: signupDict) { (isDone) in
                DispatchQueue.main.async {
                    if isDone == true {
                        AlertManager().showAlertWithBlock(viewController: self, strMessage: MessageConstant.signUpDone, buttonTitle: "OK", handler: { (result) in
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                    else {
                        AlertManager().showAlert(withMessage: MessageConstant.signUpFail, title: APP_NAME)
                    }
                }
            }
        }
    }
    
    func setUpButtonTheme() {
        self.maleButton.setButtonContrast()
        self.femaleButton.setButtonContrast()
        self.otherButton.setButtonContrast()
    }
    
    // MARK:- IBAction Methods
    
    @IBAction func maleButtonClicked(_ sender: Any) {
        
        genderType = GenderType.Male.rawValue
        self.maleButton.isSelected = true
        self.femaleButton.isSelected = false
        self.otherButton.isSelected = false
        setUpButtonTheme()
    }
    
    @IBAction func femaleButtonClicked(_ sender: Any) {
        
        genderType = GenderType.Female.rawValue
        self.femaleButton.isSelected = true
        self.maleButton.isSelected = false
        self.otherButton.isSelected = false
        setUpButtonTheme()
    }
    
    @IBAction func otherButtonClicked(_ sender: Any) {
        
        genderType = GenderType.Other.rawValue
        self.otherButton.isSelected = true
        self.maleButton.isSelected = false
        self.femaleButton.isSelected = false
        setUpButtonTheme()
    }
}
