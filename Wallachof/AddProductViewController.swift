//
//  AddProductViewController.swift
//  Wallachof
//
//  Created by Dev2 on 21/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var imgProduct: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapDetected(_ sender: UITapGestureRecognizer) {
        debugPrint("Tap en la imagen \(sender.numberOfTouches)")

        showPictureSourceAlert()
    }

    func showPictureSourceAlert() {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)

        let cameraAction = UIAlertAction(title: "Cámara", style: .default) { (alert) in
            //TODO: Abrir Camara
        }
        alert.addAction(cameraAction)
        let albumAction = UIAlertAction(title: "Galería", style: .default){ (alert) in
            //TODO: Abrir Camara
        }
        alert.addAction(albumAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (alert) in
            //TODO: Abrir Camara
        }
        alert.addAction(cancelAction)

        present(alert, animated: true)

    }



}
