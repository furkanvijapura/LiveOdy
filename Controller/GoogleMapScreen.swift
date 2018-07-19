//
//  GoogleMapScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 13/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapScreen: UIViewController, GMSMapViewDelegate ,  CLLocationManagerDelegate {
    @IBOutlet weak var googleMaps: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        self.googleMaps.settings.allowScrollGesturesDuringRotateOrZoom = true
        self.googleMaps.settings.setAllGesturesEnabled(true)
        self.googleMaps.settings.indoorPicker = true
        let Lat = Double(lat) as! CLLocationDegrees
        let Long = Double(long) as! CLLocationDegrees
        createMarker(titleMarker: GoogMapAddress, iconMarker: #imageLiteral(resourceName: "extra_location"), latitude:Lat,longitude:Long)
        let camera = GMSCameraPosition.camera(withLatitude:Lat, longitude: Long, zoom: 16.0)
        self.googleMaps.camera = camera
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
        
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: place.formattedAddress!, iconMarker: #imageLiteral(resourceName: "Location_icon"), latitude: place.coordinate.latitude,longitude: place.coordinate.longitude)
        
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
    }

    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }
}
