//
//  ContentView.swift
//  simpleFlip
//
//  Created by Aidan Bryant on 10/12/19.
//  Copyright © 2019 Aidan Bryant. All rights reserved.
//

import SwiftUI
import CoreMotion

var tiltOut = 0
var prevTime = DispatchTime.now()
var totalRotation: CGFloat = 0
var delta: CGFloat = 10

struct ContentView: View {
    var body: some View {
        MotionView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
