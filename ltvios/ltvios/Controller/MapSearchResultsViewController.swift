//
//  MapSearchResultsViewController.swift
//  ltvios
//
//  Created by gabriel durican on 4/3/22.
//

import Foundation
import UIKit
import MapKit

protocol MapSearchResultsViewControllerDelegate {
    func updateSearchBarText(text: String?)
}

class MapSearchResultsViewController: UITableViewController, Storyboarded {
    var searchItems: [MKMapItem] = []
    var mapView: MKMapView?
    var delegate: MapSearchResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
    }
    
    func updateCurrentPin(placemark: MKPlacemark) {
        clearAnnotations()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        mapView?.addAnnotation(annotation)
        
        //zoom to the annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView?.setRegion(region, animated: true)
        
    }
    
    func addressFromPlacemark(placemark: MKPlacemark) -> String {
        //add all details received from the query to an array
        let addressDetails = [placemark.thoroughfare, placemark.subThoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country]
        //compact the array, removing nil values and then join it by a comma and a space character
        let result = addressDetails.compactMap { $0 }.joined(separator: ", ")
        
        return result
    }
    
    func clearAnnotations() {
        if let annotations = mapView?.annotations {
            mapView?.removeAnnotations(annotations)
        }
    }
    
}

extension MapSearchResultsViewController {
    //table view delegate + data source methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        let placemark = searchItems[indexPath.row].placemark
        let address = addressFromPlacemark(placemark: placemark)
        
        cell?.textLabel?.text = placemark.name
        cell?.detailTextLabel?.text = address
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
        
        let placemark = searchItems[indexPath.row].placemark
        delegate?.updateSearchBarText(text: placemark.name)
        
        self.updateCurrentPin(placemark: placemark)
    }
}

extension MapSearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView, let searchBarText = searchController.searchBar.text else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            
            guard let response = response else {
                self.searchItems = []
                self.tableView.reloadData()
                return
            }
            
            //get the up-to-5 first results. prefix method returns an ArraySlice so we need to cast it back to an array
            self.searchItems = Array(response.mapItems.prefix(5))
            self.tableView.reloadData()
        }
    }
}

extension MapSearchResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchItems.count > 0 else {
            AlertController().present(on: self, title: "No results", message: "There was nothing found for your search query. Please try a different search.") {
                self.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        self.dismiss(animated: true, completion: nil)
        
        clearAnnotations()
        
        let annotations: [MKPointAnnotation] = searchItems.map {
            let annotation = MKPointAnnotation()
            let placemark = $0.placemark
            annotation.coordinate = $0.placemark.coordinate
            annotation.title = $0.placemark.name
            if let city = placemark.locality, let state = $0.placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
            }
            
            return annotation
        }
        
        mapView?.showAnnotations(annotations, animated: true)
    }
}


