//
//  MapViewController.swift
//  Wallachof
//
//  Created by Dev2 on 22/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapProduct: MKMapView!

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapProduct.showsUserLocation = true
        mapProduct.delegate = self

        preguntarSiTienePermiso()

        // Nos devuelve un enumerado que indica si se han pedido los permisos para acceder a la localizacion

    }

    func preguntarSiTienePermiso() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func centerMapOnLocation (_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 400.0, longitudinalMeters: 400.0)

        mapProduct.setRegion(region, animated: true)

    }

}

// MARK: Mapas delegate
extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {}
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {}
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        debugPrint("didUpdate \(userLocation.coordinate)")
        centerMapOnLocation(userLocation.coordinate)
    }
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {

    }
}

