//
//  IntentHandler.swift
//  RideRequestExtension
//
//  Created by Monil.Gandhi on 28/11/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
  
  override func handler(for intent: INIntent) -> Any? {
    if intent is INRequestRideIntent {
      return RideRequestHandler()
    }
    return .none
  }

}
