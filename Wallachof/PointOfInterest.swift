//
//  PointOfInterest.swift
//  Wallachof
//
//  Created by Dev2 on 22/05/2019.
//  Copyright © 2019 CFTIC. All rights reserved.
//

import UIKit
import MapKit


class PointOfInterest: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
         self.subtitle = subtitle
         self.coordinate = coordinate
    }


}
