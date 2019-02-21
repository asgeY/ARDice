//
//  Die.swift
//  ARDice
//
//  Created by Asgedom Yohannes on 2/20/19.
//  Copyright © 2019 Asgedom Yohannes. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Die : SCNNode {
    
    var finalLocation : SCNVector3
    
    init(withFinalLocation finalLocation : SCNVector3) {
        self.finalLocation = finalLocation
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            diceNode.position = SCNVector3(x: finalLocation.x,
                                           y: finalLocation.y + diceNode.boundingSphere.radius,
                                           z: finalLocation.z)
            
            addChildNode(diceNode)
        }
        
    }
    
    func roll() {
        if let diceNode = childNode(withName: "Dice", recursively: true) {
            let randomX = Float(arc4random_uniform(4) + 1) * Float.pi/2
            let randomZ = Float(arc4random_uniform(4) + 1) * Float.pi/2
            
            diceNode.runAction(SCNAction.rotateBy(x: CGFloat(randomX * 5),
                                                  y: 0,
                                                  z: CGFloat(randomZ * 5),
                                                  duration: 0.5))
        }
    }
}
