//
//  ViewController.swift
//  TravelBookApp
//
//  Created by Yiğitcan Dursun on 6.11.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var choosenLatitude : Double = 0.0
    var choosenLongitude : Double = 0.0
    var locationManager = CLLocationManager()
    
    var selectedTitle = ""
    var selectedTitleId : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude : Double = 0.0
    var annotatiınLongitude : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.backgroundColor = UIColor.white
        self.nameTextField.delegate = self 
        nameTextField.textColor = UIColor.black
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        nameTextField.layer.cornerRadius = 5
        nameTextField.layer.borderWidth = 1

        noteTextField.backgroundColor = UIColor.white
        self.noteTextField.delegate = self
        noteTextField.textColor = UIColor.black
        noteTextField.attributedPlaceholder = NSAttributedString(string: "Note: ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        noteTextField.layer.cornerRadius = 5
        noteTextField.layer.borderWidth = 1

        mapView.delegate = self
        locationManager.delegate = self
        mapView.layer.cornerRadius = 16
        mapView.layer.borderWidth = 3
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if(selectedTitle == ""){
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
            gestureRecognizer.minimumPressDuration = 2
            mapView.addGestureRecognizer(gestureRecognizer)
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LikedPlaces")
            let idString = selectedTitleId!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        if let title =  result.value(forKey: "title") as? String {
                            annotationTitle = title
                            if let subtitle = result.value(forKey: "subtitle") as? String {
                                annotationSubtitle = subtitle
                                if let latitude = result.value(forKey: "latitude") as? Double {
                                    annotationLatitude = latitude
                                    if let longitude = result.value(forKey: "longitude") as?  Double {
                                        annotatiınLongitude = longitude
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotatiınLongitude)
                                        annotation.coordinate = coordinate
                                        mapView.addAnnotation(annotation)
                                        nameTextField.text = annotationTitle
                                        noteTextField.text = annotationSubtitle
                                        locationManager.stopUpdatingLocation()
                                        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }catch{
                print("ERROR: ")
            }
            nameTextField.textAlignment = .center
            noteTextField.textAlignment = .center
            nameTextField.isEnabled = false
            noteTextField.isEnabled = false
            saveButton.isHidden = true
        }
        let gestureRecognizerForKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizerForKeyboard)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(selectedTitle == ""){
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer){
        if(gestureRecognizer.state == .began){
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            choosenLatitude = touchedCoordinates.latitude
            choosenLongitude = touchedCoordinates.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = nameTextField.text
            annotation.subtitle = noteTextField.text
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseAnnotationId = "TravelBook"
        var markerView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseAnnotationId) as? MKMarkerAnnotationView
        
        if markerView == nil{
            markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseAnnotationId)
            markerView?.canShowCallout = true
            markerView?.tintColor = UIColor.darkGray
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            markerView?.rightCalloutAccessoryView = button
            
        }else{
            markerView?.annotation = annotation
        }
        return markerView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (selectedTitle != ""){
            if(annotationLatitude != 0.0 && annotatiınLongitude != 0.0){
                let requestedLocation = CLLocation(latitude: annotationLatitude, longitude: annotatiınLongitude)
                
                CLGeocoder().reverseGeocodeLocation(requestedLocation) { placeMarks, Error in
                    if let placeMark = placeMarks{
                        if (placeMark.count > 0){
                            
                            let newPlaceMark = MKPlacemark(placemark:  placeMark[0])
                            let item = MKMapItem(placemark: newPlaceMark)
                            item.name = self.annotationTitle
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                            item.openInMaps(launchOptions: launchOptions)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func saveCoordinatesButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "LikedPlaces", into: context)
        
        if(nameTextField.text == ""){
            makeAlert(title: "Error!", message: "Name can't be empty.")
            
        }else{
            newPlace.setValue(nameTextField.text, forKey: "title")
            newPlace.setValue(noteTextField.text, forKey: "subtitle")
            newPlace.setValue(choosenLatitude, forKey: "latitude")
            newPlace.setValue(choosenLongitude, forKey: "longitude")
            newPlace.setValue(UUID(), forKey: "id")
        }
        do{
            try context.save()
            print("Success")
            
        }catch{
            print("COULD NOT SAVED")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
    }
        func makeAlert(title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}
