
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
import CoreLocation

enum Location {
    case startLocation
    case destinationLocation
    
}
class RouteViewController: UIViewController, GMSMapViewDelegate ,  CLLocationManagerDelegate {
  
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    @IBOutlet var lbldistance: UILabel!
    @IBOutlet var lblDuration: UILabel!
    var Place = GMSPlacesClient()
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    var wayPoint = CLLocation()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(RouteViewController.back(sender:)))

        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
         locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        //Your map initiation code
//        let camera = GMSCameraPosition.camera(withLatitude:(locationManager.location?.coordinate.latitude)!, longitude:(locationManager.location?.coordinate.longitude)!, zoom: 15.0)
//
//        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        self.googleMaps.settings.allowScrollGesturesDuringRotateOrZoom = true
        self.googleMaps.settings.setAllGesturesEnabled(true)
        self.googleMaps.settings.indoorPicker = true
 
       
        if Reachability.isConnectedToNetwork(){
            for i in 0..<aarAddressCount.count
            {
                let address = aarAddressCount[i]
                geoCodeUsingAddress(address: address as! NSString)
            }
            let camera = GMSCameraPosition.camera(withLatitude:(locationManager.location!.coordinate.latitude), longitude:(locationManager.location!.coordinate.longitude), zoom: 15.0)
            
            self.googleMaps.camera = camera
        }else{
            self.displayAlertMessage(messageToDisplay: "Internet/Server Connection not Available!")
        }
 

    }
   
    //Get lat long from full address
    func geoCodeUsingAddress(address: NSString) -> CLLocationCoordinate2D {
        var latitude: Double = 0
        var longitude: Double = 0
        let addressstr : NSString = "https://maps.google.com/maps/api/geocode/json?sensor=false&address=\(address)&key=AIzaSyC46oZSukuaJM0jQRMOe7QCvYfnJ3NIwas" as NSString
        let urlStr  = addressstr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let searchURL: NSURL = NSURL(string: urlStr! as String)!
        do {
            let newdata = try Data(contentsOf: searchURL as URL)
            if let responseDictionary = try JSONSerialization.jsonObject(with: newdata, options: []) as? NSDictionary {
                print(responseDictionary)
                let array = responseDictionary.object(forKey: "results") as! NSArray
                if array.count != 0{
                    let dic = array[0] as! NSDictionary
                    let locationDic = (dic.object(forKey: "geometry") as! NSDictionary).object(forKey: "location") as! NSDictionary
                    latitude = locationDic.object(forKey: "lat") as! Double
                    longitude = locationDic.object(forKey: "lng") as! Double
                    self.createMarker(titleMarker: address as String , iconMarker:#imageLiteral(resourceName: "Map-Marker"), latitude: latitude,longitude: longitude)
                    self.createMarker(titleMarker: "Your Current Location", iconMarker: #imageLiteral(resourceName: "map-marker-odin") , latitude: (self.locationManager.location?.coordinate.latitude)!, longitude:(self.locationManager.location?.coordinate.longitude)!)
                    
                    let startLocation001 = CLLocation(latitude:(self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!)
                    let endLocation001 = CLLocation(latitude: latitude, longitude: longitude)
                    self.drawPath(startLocation: startLocation001, endLocation: endLocation001)
                }
                
            }} catch {
        }
        var center = CLLocationCoordinate2D()
        center.latitude = latitude
        center.longitude = longitude
        return center
    }
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }
    //MARK: - Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
//        let waypoint = "\(wayPoint.coordinate.latitude),\(wayPoint.coordinate.longitude)"

        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&sensor=false"
        Alamofire.request(url).responseJSON { response in
            let json = try? JSON(data: response.data!)
            let routes = json!["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 3
                polyline.strokeColor = UIColor.red
                polyline.map = self.googleMaps
            }
        }
    }
    
    // MARK: when start location tap, this will open the search location
    @IBAction func openStartLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self as GMSAutocompleteViewControllerDelegate
        
        // selected location
        locationSelected = .startLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    // MARK: when destination location tap, this will open the search location
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self as? GMSAutocompleteViewControllerDelegate
        
        // selected location
        locationSelected = .destinationLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    
    // MARK: SHOW DIRECTION WITH BUTTON
    @IBAction func showDirection(_ sender: UIButton) {
        // when button direction tapped, must call drawpath func
      //  downloadJson()
        drawPath(startLocation: locationStart, endLocation: locationEnd)
    }
    
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}
// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension RouteViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )
        // set coordinate to text
        if locationSelected == .startLocation {
            startLocation.text = place.formattedAddress
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: place.formattedAddress!, iconMarker: #imageLiteral(resourceName: "Location_icon"), latitude: place.coordinate.latitude,longitude: place.coordinate.longitude)
        }
            
        else
        {
            destinationLocation.text = place.formattedAddress
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            wayPoint = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)

            createMarker(titleMarker: place.formattedAddress!, iconMarker: #imageLiteral(resourceName: "Location_icon"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}

//func downloadJson() {
//
//    Alamofire.request("https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)&destinations=\(locationEnd.coordinate.latitude)%2C\(locationEnd.coordinate.longitude)%7C&key=AAIzaSyD7mKlByQEv9212VeYA5V20CdvDbvBR9t0").responseJSON { response in
//        debugPrint(response)
//
//        if let json = response.data
//        {
//            let data = try? JSON(data: json)
//            print("Your API data...",data)
//
//            let distance = ((((data!["rows"].object as! NSArray).value(forKey: "elements") as! NSArray).value(forKey: "distance") as! NSArray).value(forKey: "text") as! NSArray)
//            let duration = ((((data!["rows"].object as! NSArray).value(forKey: "elements") as! NSArray).value(forKey: "duration") as! NSArray).value(forKey: "text") as! NSArray)
//
//            //Delete specific character
//            let badchar = CharacterSet(charactersIn: "\"() ")
//
//            let string = String(describing: distance)
//            let distancestring = string.components(separatedBy: badchar).joined()
//            self.lbldistance.text = distancestring.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            let string02 = String(describing: duration)
//            let durationstring = string02.components(separatedBy: badchar).joined()
//            self.lblDuration.text =  durationstring.trimmingCharacters(in: .whitespacesAndNewlines)
//        }
//    }
//}

