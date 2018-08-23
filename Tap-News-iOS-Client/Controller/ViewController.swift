//
//  ViewController.swift
//  Tap-News-iOS-Client
//
//  Created by Yitong Wu on 2018/8/22.
//  Copyright © 2018 Yitong Wu. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.image = UIImage(named: "Logo")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func login(_ sender: UIButton) {
        SVProgressHUD.show()
        
        let url = "http://localhost/users/login"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let params: [String: String] = [
            "email": emailTextField.text!,
            "password": passwordTextField.text!
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if response.response?.statusCode == 200 {
                    let json = JSON(response.result.value!)
                    
                    let token = json["token"].stringValue
                    let expiresAt = Int(json["expiresAt"].stringValue)!
                    print (json)
                    
                } else {
                    print ("Error")
                }
        }
        
        SVProgressHUD.dismiss()
    }
}

