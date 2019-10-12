//
//  Flip.swift
//  simpleFlip
//
//  Created by Aidan Bryant on 10/12/19.
//  Copyright © 2019 Aidan Bryant. All rights reserved.
//

import SwiftUI
import CoreMotion

struct Flip: View {
    var body: some View {
        MotionView()
    }
}

struct Flip_Previews: PreviewProvider {
    static var previews: some View {
        Flip()
    }
}

struct MotionView: View {

@State private var labelText: String = "tiltOut"
    var motionManager = CMMotionManager()
var body: some View {
    Text(self.labelText)
       .onAppear {
          self.startGyro()
          self.labelText = "\(tiltOut)"

       }
    }
func startGyro() {
motionManager.gyroUpdateInterval = 0.2
motionManager.startGyroUpdates(to: OperationQueue.current!) {
 (data, Error) in

 if let myData = data
 {
   if myData.rotationRate.y > 3
   {
      tiltOut = tiltOut + 1
    self.labelText = "\(tiltOut)"   }
}
}
}
}
