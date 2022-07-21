//
//  ActivityViewModel.swift
//  FitViz
//
//  Created by Mike Griffin on 7/14/22.
//

import SwiftUI
import CoreLocation
import MapKit

extension ActivityView {
    class ViewModel: ObservableObject {
        var activity: FVActivity
        @AppStorage("distanceUnit") var distanceUnit = ""
        @Published var sameDistanceActivities: [FVActivity] = []
        @Published var lineCoordinates: [CLLocationCoordinate2D]
        @Published var region: MKCoordinateRegion
        let cloudkitManager = CloudKitManager()
        var activityDisplayString: String {
            get {
                return activity.distance.convertMetersToDistanceUnit(distanceUnit).formatDistanceDisplayValue()
            }
        }
        
        init(activity: FVActivity) {
            self.activity = activity
            lineCoordinates = []
            region = MKCoordinateRegion(
                // Apple Park
                center: CLLocationCoordinate2D(latitude: 37.334803, longitude: -122.008965),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
              )
        }
        
        func fetchSameDistanceActivities() {
            cloudkitManager.fetchSameDistanceActivities(activity: activity) { [self] result in
                switch result {
                case .success(let activities):
                    print("Activities of distance \(activity.distanceRange.description)")
                    print(activities)
                    sameDistanceActivities = activities
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        // TODO: Consider refactoring to a seperate struct
        func decodePolyline() {
            let data = activity.encodedPolyline.data(using: String.Encoding.utf8)!
            let byteArray = unsafeBitCast((data as NSData).bytes, to: UnsafePointer<Int8>.self)
            let length = Int(data.count)
            var position = Int(0)
            var precision: Double = 1e5
            
            var decodedCoordinates: [CLLocationCoordinate2D] = []
            
            var lat = 0.0
            var lon = 0.0

            while position < length {

                do {
                    let resultingLat = try decodeSingleCoordinate(byteArray: byteArray, length: length, position: &position, precision: precision)
                    lat += resultingLat

                    let resultingLon = try decodeSingleCoordinate(byteArray: byteArray, length: length, position: &position, precision: precision)
                    lon += resultingLon
                } catch {
                    return
                    // TODO: Refactor this if I make it return something
                }

                decodedCoordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
            }
            lineCoordinates = decodedCoordinates
            print(decodedCoordinates)
            if !lineCoordinates.isEmpty{
                let centerCoordinate = lineCoordinates[lineCoordinates.count / 2]
                let sortedLatitudes = lineCoordinates.sorted(by: {
                    $0.latitude < $1.latitude
                })
                let sortedLongitudes = lineCoordinates.sorted(by: {
                    $0.longitude < $1.longitude
                })
                let latitudeDelta = sortedLatitudes.last!.latitude - sortedLatitudes.first!.latitude
                let longitudeDelta = sortedLongitudes.last!.longitude - sortedLongitudes.first!.longitude
                let centerLatitude = sortedLatitudes.last!.latitude - (latitudeDelta / 2)
                let centerLongitude = sortedLongitudes.last!.longitude - (longitudeDelta / 2)

                print("Latitude info: ", sortedLatitudes.first!.latitude, sortedLatitudes.last!.latitude, latitudeDelta)
                print("Longitude info: ", sortedLongitudes.first!.longitude, sortedLongitudes.last!.longitude, longitudeDelta)
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude), span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
            }
        }
        
        private func decodeSingleCoordinate(byteArray: UnsafePointer<Int8>, length: Int, position: inout Int, precision: Double = 1e5) -> Double {

            guard position < length else {
                print("error decoding single coordinate")
                // TODO: Refactor this to throw an error instead
                return 0.0
            }

            let bitMask = Int8(0x1F)

            var coordinate: Int32 = 0

            var currentChar: Int8
            var componentCounter: Int32 = 0
            var component: Int32 = 0

            repeat {
                currentChar = byteArray[position] - 63
                component = Int32(currentChar & bitMask)
                coordinate |= (component << (5*componentCounter))
                position += 1
                componentCounter += 1
            } while ((currentChar & 0x20) == 0x20) && (position < length) && (componentCounter < 6)

            if (componentCounter == 6) && ((currentChar & 0x20) == 0x20) {
                print("single coordinate decoding error")
            }

            if (coordinate & 0x01) == 0x01 {
                coordinate = ~(coordinate >> 1)
            } else {
                coordinate = coordinate >> 1
            }

            return Double(coordinate) / precision
        }

    }
}
