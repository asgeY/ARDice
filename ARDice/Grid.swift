//
//  Grid.swift
//  ARDice
//
//  Created by Asgedom Yohannes on 2/20/19.
//  Copyright © 2019 Asgedom Yohannes. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Grid : SCNNode {
    var anchor: ARPlaneAnchor
    
    
    init(withPlaneAnchor planeAnchor: ARPlaneAnchor) {
        self.anchor = planeAnchor
        
        super.init()
        
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        //rotate 90 degrees around x axis
        if (planeAnchor.alignment == .horizontal) {
            //print("Horizontal plane dectected")
            self.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            self.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        }
        else {
            //print("Vertical plane dectected")
            self.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            self.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        }
        
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        
        plane.materials = [gridMaterial]
        
        self.geometry = plane
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(withAnchor anchor: ARPlaneAnchor) {
        guard let planeGeometry = self.geometry as? SCNPlane else {
            fatalError("Update called but no geometry available.")
        }
        
        planeGeometry.width = CGFloat(anchor.extent.x);
        planeGeometry.height = CGFloat(anchor.extent.z);
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        
        self.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: planeGeometry, options: nil))
    }
    
}

