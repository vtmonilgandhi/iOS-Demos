//
//  RideRequestExtension.swift
//  RideRequestExtension
//
//  Created by Monil.Gandhi on 28/11/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import Foundation
import Intents

class RideRequestHandler:
NSObject, INRequestRideIntentHandling {
 
  func handle(intent: INRequestRideIntent,
              completion: @escaping (INRequestRideIntentResponse) -> Void) {
    
    let response = INRequestRideIntentResponse(
      code: .failureRequiringAppLaunchNoServiceInArea,
      userActivity: .none)
    completion(response)
  }

  
}

