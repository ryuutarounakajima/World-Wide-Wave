//
//  WaveViewController.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/11/21.
//


import UIKit
import MapKit


class WaveViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var shouldCenterOnUserLocation: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView = MKMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView)
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        currentPositon()
        //tabBarSetting()
    }
    

    
 
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         
        print("failed to get location: \(error.localizedDescription)")
        
        /*let fakeLocation = CLLocationCoordinate2D(latitude: 35.3225, longitude: 140.3654)
        let region = MKCoordinateRegion(center: fakeLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = fakeLocation
        annotaion.title = "AQI"
        annotaion.subtitle = "100"
        mapView.addAnnotation(annotaion)
        */
    }
        
    
    func currentPositon() {
        
        let resetButton = UIButton(frame: CGRect(x: self.view.bounds.width - 60, y: view.bounds.height - 110, width: 50, height: 50))
        resetButton.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        resetButton.layer.cornerRadius = 25
        resetButton.clipsToBounds = true
        resetButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        resetButton.tintColor = UIColor.brown
        resetButton.addTarget(self, action: #selector(resetToUserLocation), for: .touchUpInside)
               
                self.view.addSubview(resetButton)
    }
    
    @objc func resetToUserLocation() {
           shouldCenterOnUserLocation = true
           if let location = locationManager.location {
               let coordinate = location.coordinate
               let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
               mapView.setRegion(region, animated: true)
           }
       }
    
}
