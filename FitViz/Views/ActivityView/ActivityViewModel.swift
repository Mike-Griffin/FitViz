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
                let latitudeDelta = (sortedLatitudes.last!.latitude - sortedLatitudes.first!.latitude) * 2
                let longitudeDelta = (sortedLongitudes.last!.longitude - sortedLongitudes.first!.longitude) * 2
                print(sortedLongitudes)
                print(sortedLatitudes)
                for (i, lat) in sortedLatitudes.enumerated() {
                    print("Latitude \(i): \(lat.latitude)")
                }
                for (i, lon) in sortedLongitudes.enumerated() {
                    print("Longitude \(i): \(lon.longitude)")
                }
                let centerLatitude = sortedLatitudes.last!.latitude - (latitudeDelta / 2)
                let centerLongitude = sortedLongitudes.last!.longitude - (longitudeDelta / 2)
                let centerPoint = middlePointOfListMarkers(listCoords: lineCoordinates)

                print("Latitude info: ", sortedLatitudes.first!.latitude, sortedLatitudes.last!.latitude, latitudeDelta)
                print("Longitude info: ", sortedLongitudes.first!.longitude, sortedLongitudes.last!.longitude, longitudeDelta)
                region = MKCoordinateRegion(center: centerPoint, span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
//                region = getCenter(coordinates: lineCoordinates)
            }
        }
        
        // This seems like it may work in some cases, but it's off for a straight line
        private func getCenter(coordinates: [CLLocationCoordinate2D], spanMultiplier: CLLocationDistance = 1.8) -> MKCoordinateRegion {
            var topLeftCoord = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRightCoord = CLLocationCoordinate2D(latitude: 90, longitude: -180)

            for coordinate in coordinates {
                topLeftCoord.longitude = min(topLeftCoord.longitude, coordinate.longitude)
                topLeftCoord.latitude = max(topLeftCoord.latitude, coordinate.latitude)

                bottomRightCoord.longitude = max(bottomRightCoord.longitude, coordinate.longitude)
                bottomRightCoord.latitude = min(bottomRightCoord.latitude, coordinate.latitude)
            }

            let cent = CLLocationCoordinate2D.init(latitude: topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5, longitude: topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5)
            let span = MKCoordinateSpan.init(latitudeDelta: abs(topLeftCoord.latitude - bottomRightCoord.latitude) * spanMultiplier, longitudeDelta: abs(bottomRightCoord.longitude - topLeftCoord.longitude) * spanMultiplier)

            return MKCoordinateRegion(center: cent, span: span)
        }
        
        // MARK: Calculate Center point
        /** Degrees to Radian **/

        private func degreeToRadian(_ angle: CLLocationDegrees) -> CGFloat{

            return (  (CGFloat(angle)) / 180.0 * CGFloat(M_PI)  )

        }

        //        /** Radians to Degrees **/

        private func radianToDegree(_ radian: CGFloat) -> CLLocationDegrees{

            return CLLocationDegrees(  radian * CGFloat(180.0 / M_PI)  )

        }

        private func middlePointOfListMarkers(listCoords: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D{

            var x = 0.0 as CGFloat

            var y = 0.0 as CGFloat

            var z = 0.0 as CGFloat



            for coordinate in listCoords{

                let lat:CGFloat = degreeToRadian(coordinate.latitude)

                let lon:CGFloat = degreeToRadian(coordinate.longitude)

                x = x + cos(lat) * cos(lon)

                y = y + cos(lat) * sin(lon);

                z = z + sin(lat);

            }

            x = x/CGFloat(listCoords.count)

            y = y/CGFloat(listCoords.count)

            z = z/CGFloat(listCoords.count)



            let resultLon: CGFloat = atan2(y, x)

            let resultHyp: CGFloat = sqrt(x*x+y*y)

            let resultLat:CGFloat = atan2(z, resultHyp)



            let newLat = radianToDegree(resultLat)

            let newLon = radianToDegree(resultLon)

            let result:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: newLat, longitude: newLon)

            return result

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
