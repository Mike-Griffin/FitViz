//
//  MapView.swift
//  FitViz
//
//  Created by Mike Griffin on 7/17/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let region: MKCoordinateRegion
    let lineCoordinates: [CLLocationCoordinate2D]
    @Binding var loadingMap: Bool
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        #if DEBUG
        let _ = Self._printChanges()
        #endif
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        let regionVal = mapView.region.center
        let varRegionSpan = region.span
        let regionSpan = mapView.region.span
        let visibleMapRect = mapView.visibleMapRect
        print("Viewmodel region span: \(region.span)")
        print("Viewmodel region center: \(region.center)")
        
        if !lineCoordinates.isEmpty {
            let polyline = MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
            mapView.addOverlay(polyline)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
//        uiView.setRegion(region, animated: true)
//        for i in 0 ... 5 {
//            if uiView.region.span.latitudeDelta != region.span.latitudeDelta {
        if loadingMap {
            print(Date())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                uiView.setRegion(region, animated: false)
                uiView.regionThatFits(region)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    loadingMap = false
                }
            }
        }
//            } else {
//                break;
//            }

//        print("Update UI View called with region \(region)")
//        print("Unfortunately the thing is \(uiView.region)")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemBlue
            renderer.lineWidth = 3
            return renderer
        }
        
        return MKOverlayRenderer()
    }
}
