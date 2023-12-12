//
//  MainViewController.swift
//  Kiran_PadinhareKUnnoth_FE_8940891
//
//  Created by IS on 2023-12-09.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController,CLLocationManagerDelegate  {
    
    
    
    
    @IBOutlet weak var mapui: MKMapView!
    
    var locationManager = CLLocationManager ()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let userLocation = locations.last?.coordinate else
        {
                       return
                   }

                   
                   let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                   mapui.setRegion(region, animated: true)

                   // Optionally, you can add a pin to mark the user's location
                   let annotation = MKPointAnnotation()
                   annotation.coordinate = userLocation
                   annotation.title = "Current Location"
                   mapui.addAnnotation(annotation)

                   // Stop updating location to conserve battery
                   locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        
        locationManager.delegate = self
        //mapui.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapui.showsUserLocation = true
    }
    
    func navigateToMapScene(cityName: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use your storyboard name
        
        if let mapViewController = storyboard.instantiateViewController(withIdentifier: "Map") as? MapViewController {
            
            // Pass data to the second view controller
            mapViewController.convertAddress(cityName: cityName)
            
            navigationController?.pushViewController(mapViewController, animated: false)
            
        }}
    func navigateToNewsScene(cityName: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use your storyboard name

        if let newsViewController = storyboard.instantiateViewController(withIdentifier: "News") as? NewsTableViewController {
                     
                     // Pass data to the second view controller
            newsViewController.getCityNews(cityName: cityName)
                     
                     navigationController?.pushViewController(newsViewController, animated: false)
                     
                 }

    }
    func navigateToWhetherScene(cityName: String){
        
        // Instantiate the second view controller from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Use your storyboard name
        if let weatherViewController = storyboard.instantiateViewController(withIdentifier: "Weather") as? WeatherViewController {
            
            // Pass data to the second view controller
            weatherViewController.getWeatherData(cityName: cityName)
            
            navigationController?.pushViewController(weatherViewController, animated: false)
            
        }
        
    }
    
    
    @IBAction func locationDetails(_ sender: UIButton) {
        // Create the alert controller
         let alertController = UIAlertController(title: "Input Required", message: "Please enter the name of the city", preferredStyle: .alert)

         // Add a text field to the alert controller
         alertController.addTextField { (cityTextField) in
             cityTextField.placeholder = "Enter city name"
         }

         // Create the OK action
         let newsAction = UIAlertAction(title: "News", style: .default) { (_) in
             // Retrieve the city name entered by the user
             if let cityName = alertController.textFields?[0].text {
                 // Geocode the city name to get coordinates
                 self.navigateToNewsScene(cityName: cityName)

             }
         }
        let mapAction = UIAlertAction(title: "Map", style: .default) { (_) in
             // Retrieve the city name entered by the user
             if let cityName = alertController.textFields?[0].text {
                 // Geocode the city name to get coordinates
                self.navigateToMapScene(cityName: cityName)
             }
         }
        let weatherAction = UIAlertAction(title: "Weather", style: .default) { (_) in
             // Retrieve the city name entered by the user
             if let cityName = alertController.textFields?[0].text {
                 // Geocode the city name to get coordinates
                 self.navigateToWhetherScene(cityName: cityName)
             }
         }

         // Add the action to the alert controller
         alertController.addAction(newsAction)
         alertController.addAction(weatherAction)
         alertController.addAction(mapAction)

         // Present the alert controller
         self.present(alertController, animated: true, completion: nil)

    }
    
    
    
        
       
    
    
}
