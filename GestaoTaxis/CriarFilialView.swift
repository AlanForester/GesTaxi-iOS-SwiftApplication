//
//  CriarFilialView.swift
//  GestaoTaxis
//
//  Created by Paulo Alves on 26/05/15.
//  Copyright (c) 2015 Paulo Alves. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CriarFilialView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var cidade: UITextField!
    
    @IBOutlet weak var mapaView: MKMapView!
  
    @IBOutlet weak var switcher: UISwitch!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switcher.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var latitude:CLLocationDegrees = 41.694641
        
        var longitude:CLLocationDegrees = -8.846876
        
        var latitudeDelta:CLLocationDegrees = 0.02
        var longitudeDelta:CLLocationDegrees = 0.02
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location,span)
        
        mapaView.setRegion(region, animated: true)
           
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
           mapaView.alpha = 1
        } else {
           mapaView.alpha = 0
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var localRecebido:CLLocation = locations[0] as! CLLocation
        var longitude:CLLocationDegrees = localRecebido.coordinate.longitude
        var latitude:CLLocationDegrees = localRecebido.coordinate.latitude
        self.longitude.text = longitude.description
        self.latitude.text = latitude.description
        
        
        var localizacao:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //animaMapa(location)
        
        //criaAnotacao(localRecebido)
        reverseGeoCode(localRecebido)
        
    }
    
    func reverseGeoCode(localRecebido: CLLocation){
        CLGeocoder().reverseGeocodeLocation(localRecebido, completionHandler: {(placemarks, error) in
        
        if((error) != nil){
            println("erro")
        } else {
            let p = CLPlacemark(placemark: placemarks[0] as! CLPlacemark)
            self.cidade.text = "\(p.subLocality)"
        }
        
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
