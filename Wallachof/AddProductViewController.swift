//
//  AddProductViewController.swift
//  Wallachof
//
//  Created by Dev2 on 21/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    enum ImageSource {
        case photoLibrary
        case camera
    }

    var imagePicker: UIImagePickerController!


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

        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet)

            let cameraAction = UIAlertAction(title: "Cámara", style: .default) { (alert) in
                //TODO: Abrir Camara
                self.selectImageFrom(.camera)
            }
            alert.addAction(cameraAction)
            let albumAction = UIAlertAction(title: "Galería", style: .default){ (alert) in
                //TODO: Abrir Camara
                  self.selectImageFrom(.photoLibrary)

            }
            alert.addAction(albumAction)
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (alert) in
                //TODO: Abrir Camara

            }
            alert.addAction(cancelAction)

            present(alert, animated: true)
            }
        else {
                selectImageFrom(.photoLibrary)
            }
    }

    func selectImageFrom(_ source: ImageSource) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
                imagePicker.sourceType = .photoLibrary
        }

        present(imagePicker, animated: true)

    }



}
extension AddProductViewController:UINavigationControllerDelegate {}
extension AddProductViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // 1. cerrar el picker controller
            picker.dismiss(animated: true)
        // 2. Coger la imagen (info es un diccionario con claves enumeradas del tipo UIImagePickerController.InfoKey)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            debugPrint("Error no se puede conseguir la iamgen")
            return
        }

        imgProduct.image = selectedImage

    }

}
