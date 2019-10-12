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
    motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, Error) in
        if let myData = data {
            let currTime = DispatchTime.now()
            let dt = prevTime.distance(to: currTime).milliseconds
            prevTime = currTime
            // assuming rotationRate is in degrees/millisecond.
            dTheta = myData.rotationRate.y * dt
            // If not milliseconds, convert dt to correct time unit
            // If rotationRate is in radians, convert to degrees or make future comparison check for 2*pi instead of 360 degrees
            totalRotation += dTheta
            if totalRotation > 360 - delta && totalRotation < 360 + delta {
                tiltOut = tiltOut + 1
                self.labelText = "\(tiltOut)"
                totalRotation -= 360
            }
        }
    }
}
}
