//
//  UpdateService.swift
//  ride-along-development
//
//  Created by Alisher Abdukarimov on 1/11/18.
//  Copyright © 2018 Alisher Abdukarimov. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MapKit

class UpdateService {
    
    static let instance = UpdateService()
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.key == Auth.auth().currentUser?.uid {
                        if driver.childSnapshot(forPath: "isOnline").value as! Bool == true {
                            DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues(["coordinate" : [coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        }
    }
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            if let passengerSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for passenger in passengerSnapshot {
                    if passenger.key == Auth.auth().currentUser?.uid {
                        DataService.instance.REF_USERS.child(passenger.key).updateChildValues(["coordinate" : [coordinate.latitude, coordinate.longitude]])
                    } 
                }
            }
        }
    }
}
