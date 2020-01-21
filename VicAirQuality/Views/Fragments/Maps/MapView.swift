//
//  MapView.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: NSViewRepresentable {

    @Binding var pins: [MapPin]
    @Binding var selectedPin: MapPin?
    
    // State of Victoria
    let region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -37.4713, longitude: 145.7852),
                                                        latitudinalMeters: CLLocationDistance(exactly: 580000.0)!,
                                                        longitudinalMeters: CLLocationDistance(exactly: 267190.0)!)
    
    func makeNSView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        view.setRegion(region, animated: true)
        view.showsZoomControls = true
        
        return view
    }
    
    func updateNSView(_ nsView: MKMapView, context: Context) {
        nsView.removeAnnotations(nsView.annotations)
        nsView.addAnnotations(pins)
        if let selectedPin = selectedPin {
            nsView.selectAnnotation(selectedPin, animated: false)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedPin: $selectedPin)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var selectedPin: MapPin?
        
        init(selectedPin: Binding<MapPin?>) {
            _selectedPin = selectedPin
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let pin = view.annotation as? MapPin else {
                return
            }
            
            UserDefaults.set(defaultSiteID: pin.siteID)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? MapPin else { return nil }
            
            let identifier = "airSite\(annotation.color)"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.pinTintColor = annotation.color
            }
            return view
        }
    }
}
