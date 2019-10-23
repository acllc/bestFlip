//
//  Flip.swift
//  simpleFlip
//
//  Created by Aidan Bryant on 10/12/19.
//  Copyright © 2019 Aidan Bryant. All rights reserved.
//

import SwiftUI
import CoreMotion
import Foundation

var totalRotation: CGFloat = 0
var delta: CGFloat = 10

extension DispatchTimeInterval {
    func toDouble() -> Double? {
        var result: Double? = 0

        switch self {
        case .seconds(let value):
            result = Double(value)
        case .milliseconds(let value):
            result = Double(value)*0.001
        case .microseconds(let value):
            result = Double(value)*0.000001
        case .nanoseconds(let value):
            result = Double(value)*0.000000001

        case .never:
            result = nil
        }

        return result
    }
}

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
    @State private var prevTime = DispatchTime.now()
func startGyro() {
    motionManager.gyroUpdateInterval = 0.2
    motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, Error) in
        if let myData = data {
            let currTime = DispatchTime.now()
            var dt = 0
            let interval = self.prevTime.distance(to: currTime)
            if case .milliseconds(let value) = interval {
                dt = value
            }
            self.prevTime = currTime
            // assuming rotationRate is in degrees/millisecond.
            let dTheta: CGFloat = CGFloat(myData.rotationRate.y) * CGFloat(dt)
            
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
