//
//  MapViewController.swift
//  Venatus
//
//  Created by Douglas on 3/24/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, EventViewControllerDelegate {

    
    @IBOutlet var createEventButton: UIButton!
    
    @IBOutlet var mapView: MKMapView!
    
    var lat: Double?
    var lon: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
            MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: true)
    }
    
    /* Adds annotation(pin) onto the map */

    func addPin(lat: Double, lon: Double) {
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2DMake(lat, lon)
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
        mapView.gestureRecognizers?.removeAll()
    }

    /* Create button pressed, allow user to create pin on map and segue into other VC */
    @IBAction func creatingEvent(sender: AnyObject) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "getLocationOfTapAndSegue:")
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /* Grab location of tap and perform seque */
    func getLocationOfTapAndSegue(sender: UITapGestureRecognizer) {
        //if sender.state != UIGestureRecognizerState.Began { return }
        let touchLocation = sender.locationInView(mapView)
        let locationCoordinate = mapView.convertPoint(touchLocation, toCoordinateFromView: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        //addPin(Double(locationCoordinate.latitude), lon: Double(locationCoordinate.longitude))
        lat = Double(locationCoordinate.latitude)
        lon = Double(locationCoordinate.longitude)
        performSegueWithIdentifier("eventSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! EventViewController
        vc.lat = self.lat
        vc.lon = self.lon
        vc.delegate = self
    }

    /* Delegated method*/
    func locationPicked(controller: EventViewController, latitude: Double, longitude: Double) {
        navigationController?.popToViewController(self, animated: true)
        addPin(latitude, lon: longitude)
    }

}
