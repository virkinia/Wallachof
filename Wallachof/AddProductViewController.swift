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

    @IBOutlet weak var pickerPublishDate: UIDatePicker!
    @IBOutlet weak var pickerCategory: UIPickerView!

    @IBOutlet weak var scrollFormView: UIScrollView!

    @IBOutlet weak var descTextField: UITextField!
    
    let categorias0 = ["electrónica", "moda", "automoción", "hogar"]
    let categorias1 = ["zapatos", "bolsos", "accesorios"]


    @IBOutlet weak var imgProduct: UIImageView!
    override func viewDidLoad() {


        super.viewDidLoad()

        descTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


        pickerCategory.delegate = self
        pickerCategory.dataSource = self

        // Do any additional setup after loading the view.
    }

    @objc func keyboardWillShow(notification: Notification) {
        debugPrint("El teclado se abre")
        adjustScrollForKeyboardShow(true, notification: notification)

    }
    @objc func keyboardWillHide(notification: Notification) {
        debugPrint("El teclado se cierra")
         adjustScrollForKeyboardShow(false, notification: notification)
    }

    func adjustScrollForKeyboardShow(_ show: Bool, notification: Notification) {
        guard let userInfo = notification.userInfo,
              let frameValue  = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
            return
        }

        // Cuadrado donde se inicia y tamaño CGRect -> NSValue(Objective)
        let keyBoardFrame = frameValue.cgRectValue
        let resizeInset = show ? keyBoardFrame.height : -keyBoardFrame.height

        scrollFormView.contentInset.bottom = resizeInset
        scrollFormView.scrollIndicatorInsets.bottom = resizeInset
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


    @IBAction func pickerDatePublishChange(_ sender: UIDatePicker) {
        debugPrint("Ha cambiado \(sender.date)")
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

        let context = CoreDataManager.shared.persistentContainer.viewContext
        let flores = Product(context: context)
        flores.name = "Florecillas de la pradera"
        flores.desc = "Mogollón de alergia"
        flores.price = 15.0

     /*   if let dataPng = selectedImage.pngData() {
            //dataPng de tipo Data
            flores.thumb = NSData(data: dataPng)
        }*/

        let thumbImage = selectedImage.resizeImage(targetSize: CGSize(width: 100, height: 100))
        if let dataJpg = thumbImage.jpegData(compressionQuality: 0.8) {
            //dataJPG de tipo Data
            flores.thumb = NSData(data: dataJpg)
        }

        CoreDataManager.shared.saveContext()

    }

}

extension AddProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // Dos columnas Categorias - Cambiar
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (component == 0){
           return categorias0.count
        } else if component == 1 {
           return categorias1.count
        }
        return 0
    }


}

extension AddProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch component {
        case 0:
            return categorias0[row]
        case 1:
              return categorias1[row]

        default:
            debugPrint("Error no debería llegar")
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let fila0 = pickerView.selectedRow(inComponent: 0)
        let fila1 = pickerView.selectedRow(inComponent: 1)

        debugPrint("Todos \(categorias0[fila0]) y \(categorias1[fila1])")

        var rowText = ""

        switch component {
        case 0:
            rowText = categorias0[row]
        case 1:
            rowText = categorias1[row]

        default:
            debugPrint("Error no debería llegar")
        }

        debugPrint("Se ha seleccionado \(rowText)")

    }

}
extension AddProductViewController: UITextFieldDelegate {

    // Cuando el usuario pulsa intro - salta este delegado
    // y fuerzo el cerrar el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // textField.endEditing(force: true)
        return true
    }
}
