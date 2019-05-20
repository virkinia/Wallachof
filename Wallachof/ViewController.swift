//
//  ViewController.swift
//  Wallachof
//
//  Created by Dev2 on 20/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnTestPressed(_ sender: Any) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        debugPrint("Dino")
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        let dinoDetector = Product(context: context)
        dinoDetector.name = "Dino Detector Ultimate 🦖"
        dinoDetector.desc = "Último modelo, la tecnología más puntera"
        dinoDetector.price = 2000.0

        appDelegate.saveContext()


    }

}

