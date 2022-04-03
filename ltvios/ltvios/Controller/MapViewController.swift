//
//  MapViewController.swift
//  ltvios
//
//  Created by gabriel durican on 3/31/22.
//

import Foundation
import UIKit
import MapKit

class MapViewController: BaseTabPageViewController, MapCoordinated, MKMapViewDelegate, UISearchBarDelegate {
    var coordinator: MapCoordinatorStandard?
    let locationManager = CLLocationManager()
    var searchController: UISearchController?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controllerTitle = "Map"
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        linkSearchControllerToTabBar()
        clearSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleLocationPermissions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchController?.searchBar.resignFirstResponder()
    }
    
    func linkSearchControllerToTabBar() {
        self.tabBarController?.navigationItem.searchController = searchController
    }
    
    func clearSearchBar() {
        searchController?.searchBar.text = nil
    }
    
    func setupSearchController() {
        if searchController == nil {
            let searchResultsTableVC = MapSearchResultsViewController.instantiateFromStoryboard()
            searchResultsTableVC.delegate = self
            
            searchController = UISearchController(searchResultsController: searchResultsTableVC)
            searchController?.searchResultsUpdater = searchResultsTableVC
            searchResultsTableVC.mapView = mapView
            
            //have the search bar be displayed at all times
            searchController?.hidesNavigationBarDuringPresentation = false
            
            //searchBar appearance
            let searchBar = searchController?.searchBar
            searchBar?.tintColor = .black
            searchBar?.searchTextField.attributedPlaceholder = NSAttributedString(string:"Search for location...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            searchBar?.searchTextField.textColor = .black
            searchBar?.searchTextField.backgroundColor = .white
            searchBar?.delegate = searchResultsTableVC
            
            //cancel button color
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
            
            definesPresentationContext = true
        }
        
        
    }
    
    func handleLocationPermissions() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            fallthrough
        case .restricted:
            showNeedsPermissionAlert()
            break
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            break
        @unknown default:
            print("Apple added another case here, this should be handled in a future version.")
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
 
    func showNeedsPermissionAlert() {
        let title = "Location permission"
        let message = "Location permission is needed for this app. Please go to settings and allow the permission"
        
        AlertController().present(on: self, title: title, message: message) {
            self.coordinator?.parentCoordinator?.resetToRoot()
        }
    }
    
    func zoomOnLocation(location: CLLocation) {
        var region = MKCoordinateRegion()
        region.center.latitude = location.coordinate.latitude;
        region.center.longitude = location.coordinate.longitude;
        region.span.latitudeDelta = 0.05;
        region.span.longitudeDelta = 0.05;
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        } else {
            showNeedsPermissionAlert()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error with the location detection \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        zoomOnLocation(location: location)
        
    }
}

extension MapViewController: MapSearchResultsViewControllerDelegate {
    func updateSearchBarText(text: String?) {
        let sb = searchController?.searchBar
        sb?.text = text
    }
}
