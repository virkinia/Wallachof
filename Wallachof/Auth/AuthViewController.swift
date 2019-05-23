//
//  AuthViewController.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!

    @IBOutlet weak var passwordInput: UITextField!

   
    @IBOutlet weak var viewForm: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let bgPatter = UIImage(named: "bg-login")

        view.backgroundColor = UIColor(patternImage: bgPatter!)

        viewForm.layer.cornerRadius = 10.0
        viewForm.layer.borderWidth = 2.0
        viewForm.layer.borderColor = UIColor.black.cgColor

        viewForm.layer.shadowColor = UIColor.gray.cgColor

        viewForm.layer.shadowOpacity = 0.8


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
