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
    var annoImage: UIImage?
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

    func addPin(lat: Double, lon: Double, title: String?){
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2DMake(lat, lon)
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
        if let title = title{
            annotation.title = title
        }
        mapView.gestureRecognizers?.removeLast()
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
        if segue.identifier == "eventSegue"{
            let vc = segue.destinationViewController as! EventViewController
            vc.lat = self.lat
            vc.lon = self.lon
            vc.delegate = self
        }
    }

    /* Delegated method*/
    func locationPicked(controller: EventViewController, latitude: Double, longitude: Double, title: String?, image: UIImage?) {
        navigationController?.popToViewController(self, animated: true)
        if let image = image{
            annoImage = image
        }
        addPin(latitude, lon: longitude, title: title)
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        print("beep")
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
        }
        
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        if let annoImage = annoImage{
            imageView.image = annoImage
        }
        
        let button = UIButton(type: .Custom)
        //let button = annotationView?.rightCalloutAccessoryView as! UIButton
        
        button.frame = CGRectMake(0,0,50,50)
        button.addTarget(self, action: "clickedCallOut:", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.setImage(UIImage(named: "Venatus Logo"), forState: .Normal)
        annotationView?.rightCalloutAccessoryView = button
        return annotationView
    }
    
    func clickedCallOut(sender: UIButton){
        print("CallOutClicked")
        performSegueWithIdentifier("viewSegue", sender: self)
    }
}
