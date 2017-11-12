//
//  ViewController.swift
//  SceneKitProject
//
//  Created by MacOS on 12/11/2017.
//  Copyright © 2017 amberApps. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setup()
    }
    
    func setup() {
        let scene = setupScene()
        let color = setColor()
        let color2 = setColor2()
        let target1 = setupCone(scene: scene, color: color)
        let target2 = setupCube(scene: scene, color: color, color2: color2)
        let constraint = constraints(target: target1)
        setupCamera(constraint: constraint)
        animationPosition(target1)
        animationPosition2(target2)
    }
    
    func setupCamera(constraint: SCNConstraint) {
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -5.0, y: 3.0, z: 9.0)
        cameraNode.constraints = [constraint]
    }
    
    func setupScene() -> SCNScene {
        let scene: SCNScene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        return scene
    }
    
    func setupCone(scene: SCNScene, color: SCNMaterial) -> SCNNode {
        let cone: SCNGeometry = SCNCone(topRadius: 0, bottomRadius: 1.0, height: 1.5)
        let coneNode = SCNNode(geometry: cone)
        cone.materials = [color]
        coneNode.position = SCNVector3(x: -3.0, y: 5.0, z: 9.0)
        scene.rootNode.addChildNode(coneNode)
        return coneNode
    }
    
    
    func setupCube(scene: SCNScene, color: SCNMaterial, color2: SCNMaterial) -> SCNNode {
        let cube: SCNGeometry = SCNBox(width: 0.8, height: 0.8, length: 0.8, chamferRadius: 0)
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(x: -3.0, y: 3.0, z: 9.0)
        cube.materials = [color, color2]
        scene.rootNode.addChildNode(cubeNode)
        return cubeNode
    }
    
    func animationPosition(_ node: SCNNode) {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = 0.6
        animation.toValue = 1.9
        animation.duration = 5.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        node.addAnimation(animation, forKey: "y")
    }
    
    func animationPosition2(_ node: SCNNode) {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = -0.6
        animation.toValue = -1.7
        animation.duration = 5.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        node.addAnimation(animation, forKey: "y")
    }
    
    
    func setColor() -> SCNMaterial {
        let sandMaterial = SCNMaterial()
        sandMaterial.diffuse.contents = UIImage(named: "sand")
        return sandMaterial
    }
    
    func setColor2() -> SCNMaterial {
        let brownMaterial = SCNMaterial()
        brownMaterial.diffuse.contents = UIColor(displayP3Red: 60/255, green: 36/255, blue: 6/255, alpha: 1)
        return brownMaterial
    }
    
    func constraints(target: SCNNode) -> SCNConstraint {
        let constraint = SCNLookAtConstraint(target: target)
        constraint.isGimbalLockEnabled = true
        return constraint
    }
    
}
