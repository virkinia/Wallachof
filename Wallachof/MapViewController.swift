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

    func addPointOfInterest() {

        let poi = PointOfInterest(title: "Chuchelandia", subtitle: "Se te hace el chuche agua", coordinate: CLLocationCoordinate2D(latitude: 40.300011, longitude: -3.755602))
        mapProduct.addAnnotation(poi)

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
        addPointOfInterest()
    }
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        debugPrint("Me piden info de un punto de interes \(type(of: annotation))")

        guard let annotation = annotation as? PointOfInterest
        else {
             return nil
        }

        let identifier = "podId"
        var view: MKMarkerAnnotationView
        // Dame una para reusar
        if let dequeuedView =  mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView

        } else { //Si no hay ninguna para reutilizar la uso
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        }
        return view

    }
}

