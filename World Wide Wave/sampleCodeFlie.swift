//
//  sampleCodeFlie.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/10/16.
//

import Foundation



/*
 

// ASAuthorizationControllerDelegate methods
func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
        let userIdentifier = appleIDCredential.user
        let fullName = appleIDCredential.fullName
        let email = appleIDCredential.email
        
        // Save credentials in CoreData
        saveUserInCoreData(userID: userIdentifier, name: fullName?.givenName, email: email)
        
        // Handle successful login
        print("Login successful: \(userIdentifier), \(fullName?.givenName ?? ""), \(email ?? "")")
    }
}

func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error during Apple authentication
    print("Error during Apple sign-in: \(error.localizedDescription)")
}

// CoreData save function
func saveUserInCoreData(userID: String, name: String?, email: String?) {
    // Assuming Core Data setup with an entity "User" that has attributes "id", "name", and "email"
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let context = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
    let newUser = NSManagedObject(entity: entity, insertInto: context)
    
    newUser.setValue(userID, forKey: "id")
    newUser.setValue(name, forKey: "name")
    newUser.setValue(email, forKey: "email")
    
    do {
        try context.save()
        print("User saved to CoreData")
    } catch {
        print("Failed to save user: \(error)")
    }
}
}
 
 // checking if user logged in or not
 import UIKit
 import AuthenticationServices

 class SceneDelegate: UIResponder, UIWindowSceneDelegate {

     var window: UIWindow?

     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
 
 
 
         guard let windowScene = (scene as? UIWindowScene) else { return }

         let window = UIWindow(windowScene: windowScene)

         // ユーザーが既にログインしているかチェック
         if UserDefaults.standard.bool(forKey: "appoleAuthToken") {
             // ログイン済みの場合、メインタブバーを表示
             let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
             mainTabBarController.selectedIndex = 2  // 移動したいタブのインデックス

             window.rootViewController = mainTabBarController
         } else {
             // ログイン画面を表示
             let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
             window.rootViewController = loginViewController
         }

         self.window = window
         window.makeKeyAndVisible()
     }
 }
 
 //ASAuthorizationControllerDelegate methods
 
 func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
     
     if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
         
         let appleAuthToken = appleIDCredential.identityToken != nil ? String(data: appleIDCredential.identityToken!, encoding: .utf8) : "nilだよ~ん"
         UserDefaults.standard.set(appleAuthToken, forKey: "appleAuthToken")
         
         let userIdentifier = appleIDCredential.user
         let fullName = appleIDCredential.fullName
         let email = appleIDCredential.email
         
         let identifierString = userIdentifier.isEmpty ? "nilだよ~ん" : userIdentifier
         let givenName = fullName?.givenName ?? "nilだよ~ん"
         let emailString = email ?? "nilだよ~ん"
         
         print("Login successful: \(identifierString), \(givenName), \(emailString)")
         
         let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
         tabBarVC.tabBarController?.selectedIndex = 0
         
         self.view.window?.rootViewController = tabBarVC
         self.view.window?.makeKeyAndVisible()
     }
 }
 
 mark:: map setting uikit
 import UIKit
 import MapKit

 class ViewController: UIViewController, CLLocationManagerDelegate {
     var mapView: MKMapView!
     var locationManager: CLLocationManager!

     override func viewDidLoad() {
         super.viewDidLoad()

         // 地図を作成
         mapView = MKMapView(frame: self.view.bounds)
         mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         self.view.addSubview(mapView)

         // 現在位置を表示する設定
         mapView.showsUserLocation = true
         mapView.userTrackingMode = .follow

         // 位置情報の許可と設定
         locationManager = CLLocationManager()
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
     }

     // 位置情報の許可状態が変更された場合の処理
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         switch status {
         case .authorizedWhenInUse, .authorizedAlways:
             locationManager.startUpdatingLocation()
         case .denied, .restricted:
             print("位置情報の利用が許可されていません。")
         default:
             break
         }
     }

     // 位置情報が更新された場合の処理
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let location = locations.last else { return }

         // 現在位置を地図の中心に設定
         let coordinate = location.coordinate
         let region = MKCoordinateRegion(
             center: coordinate,
             span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
         )
         mapView.setRegion(region, animated: true)
     }

     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("位置情報の取得に失敗しました: \(error.localizedDescription)")
     }
 }
 import UIKit
 import MapKit

 class WaveViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
     var mkMapView: MKMapView!
     var locationManager: CLLocationManager!
     var selectedLocation: CLLocationCoordinate2D?
     var isTransitioning = false

     override func viewDidLoad() {
         super.viewDidLoad()

         // MapView setup
         mkMapView = MKMapView(frame: self.view.bounds)
         mkMapView.delegate = self
         self.view.addSubview(mkMapView)

         mkMapView.showsUserLocation = true
         mkMapView.userTrackingMode = .follow

         // Location manager setup
         locationManager = CLLocationManager()
         locationManager.delegate = self
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()

         // Add example annotation
         let exampleAnnotation = MKPointAnnotation()
         exampleAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // Example coordinate
         exampleAnnotation.title = "Example Location"
         mkMapView.addAnnotation(exampleAnnotation)
     }

     // Annotation tap handling
     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
         guard let annotation = view.annotation, !(annotation is MKUserLocation) else {
             // Ignore user location annotation
             return
         }

         if isTransitioning { return } // Prevent double transitions
         isTransitioning = true

         // Save selected annotation location
         selectedLocation = annotation.coordinate

         // Navigate to the WaveInfoViewController
         navigateToWaveInfoViewController()
     }

     // Navigate to WaveInfoViewController
     func navigateToWaveInfoViewController() {
         let waveInfoVC = WaveInfoViewController()
         waveInfoVC.coordinate = selectedLocation
         navigationController?.pushViewController(waveInfoVC, animated: true)

         // Reset the transition flag after navigation
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             self.isTransitioning = false
         }
     }
 }

 class WaveInfoViewController: UIViewController {
     var coordinate: CLLocationCoordinate2D?

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white

         // Display the passed coordinate
         if let coordinate = coordinate {
             let coordinateLabel = UILabel()
             coordinateLabel.text = "Latitude: \(coordinate.latitude), Longitude: \(coordinate.longitude)"
             coordinateLabel.textAlignment = .center
             coordinateLabel.translatesAutoresizingMaskIntoConstraints = false

             view.addSubview(coordinateLabel)
             NSLayoutConstraint.activate([
                 coordinateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 coordinateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
             ])
         }
     }
 }

*/
