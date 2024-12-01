//
//  WaveViewController.swift
//  World Wide Wave

//  Created by Ryutarou Nakajima on 2024/11/21.
//


import UIKit
import MapKit



class WaveViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var mkMapView: MKMapView!
    var locationManager: CLLocationManager!
    var selectedLocation: CLLocationCoordinate2D?
    var longPressTimer: Timer?
    var isTranslateing: Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        mkMapView = MKMapView(frame: self.view.bounds)
        mkMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mkMapView)
        
        mkMapView.showsUserLocation = true
        mkMapView.userTrackingMode = .follow
        
        let longPressGesuture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mkMapView.addGestureRecognizer(longPressGesuture)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        backToCurrentPositon()
      //tabBarSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        mkMapView.delegate = self
    }

    // Add this function to set custom image for annotation
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           
           if annotation is MKUserLocation {
               return nil
           }
           
           let reuseIdentifier = "CustomAnnotation"
           
           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
           
           if annotationView == nil {
               annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
               annotationView?.canShowCallout = true
           }
           
           // Set custom image for annotation
           if let customImage = UIImage(named: "Logo") {
               // Resize image to fit the annotation view
               let resizedImage = resizeImage(image: customImage, to: CGSize(width: 30, height: 30))
               annotationView?.image = resizedImage
              
           }
           
           return annotationView
       }
       
       // Helper function to resize image to a specific size
       func resizeImage(image: UIImage, to size: CGSize) -> UIImage {
           
           let rect = CGRect(origin: .zero, size: size)
           
           UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
           
           image.draw(in: rect)
           
           var resizedImage = UIGraphicsGetImageFromCurrentImageContext()
          
           if let img = resizedImage {
               
               let diameter = min(size.width, size.height)
               let radius = diameter / 2
               let circleRect = CGRect(x: (size.width - diameter) / 2, y: (size.height - diameter) / 2, width: diameter, height: diameter)
               
               UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
               let path = UIBezierPath(roundedRect: circleRect, cornerRadius: radius)
               path.addClip()
               
               img.draw(in: circleRect)
               
               resizedImage = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               
           }
           return resizedImage ?? image
       }
    
    func navigateToWaveInfoViewController() {
        
        let WaveInfoVC = WaveInfoViewContrroler()
        WaveInfoVC.coordinate = selectedLocation!
        navigationController?.pushViewController(WaveInfoVC, animated: true)
       
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

    @objc func resetToUserLocation() {
          // shouldCenterOnUserLocation = true
           if let location = locationManager.location {
               let coordinate = location.coordinate
               let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
               mkMapView.setRegion(region, animated: true)
           }
       }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchPoint = gestureRecognizer.location(in: mkMapView)
                    let coordinate = mkMapView.convert(touchPoint, toCoordinateFrom: mkMapView)

                    // 既存のアノテーションを削除してから新しいアノテーションを追加
                    mkMapView.removeAnnotations(mkMapView.annotations)

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    mkMapView.addAnnotation(annotation)

                    // 数秒後に遷移
                    selectedLocation = coordinate
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.navigateToWaveInfoViewController()
                    }
                
            
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            
            longPressTimer?.invalidate()
            longPressTimer = nil
        }
        
    }
    
    
    private func backToCurrentPositon() {
        
        let resetButton = UIButton(frame: CGRect(x: self.view.bounds.width - 60, y: view.bounds.height - 110, width: 50, height: 50))
        resetButton.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        resetButton.layer.cornerRadius = 25
        resetButton.clipsToBounds = true
        resetButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        resetButton.tintColor = UIColor.brown
        resetButton.addTarget(self, action: #selector(resetToUserLocation), for: .touchUpInside)
               
                self.view.addSubview(resetButton)
    }
    
   
}


