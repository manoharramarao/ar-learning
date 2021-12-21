//
//  SimpleBoxWithTouch.swift
//  ar-with-touch
//
//  Created by Ramarao Manohar on 17/12/21.
//

import UIKit
import SceneKit
import ARKit

class SimpleBoxWithTouchController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set the view's delegate
            sceneView.delegate = self
            
            // Show statistics such as fps and timing information
            sceneView.showsStatistics = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
            self.sceneView.addGestureRecognizer(tapGestureRecognizer)
            
            // Create a new scene
            let scene = SCNScene()
            
            // Set the scene to the view
            sceneView.scene = scene
            
            self.sceneView.scene.rootNode.addChildNode(getBoxNode())
//            self.sceneView.scene.rootNode.addChildNode(getSphere())
            
        }
    
    @objc func tapped(recognizer: UIGestureRecognizer){
        let sceneView = recognizer.view as! SCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        
        if !hitResults.isEmpty {
            let node = hitResults[0].node
            let material = node.geometry?.material(named: "Color")
            material?.diffuse.contents = UIColor.random()
        }
    }
        
        func getBoxNode() -> SCNNode{
            let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
            let material = SCNMaterial()
            material.name = "Color"
            box.firstMaterial?.diffuse.contents = UIImage(named: "wood.jpeg")
            let boxNode = SCNNode(geometry: box)
            boxNode.geometry?.materials = [material]
            boxNode.position = SCNVector3(0, 0, -0.5)
            return boxNode
        }
        
        func getSphere() -> SCNNode{
            let sphere = SCNSphere(radius: 0.3)
            sphere.firstMaterial?.diffuse.contents = UIImage(named: "earth.jpg")
            let sphereNode = SCNNode(geometry: sphere)
            sphereNode.position = SCNVector3(0.5, 0, -0.5)
            return sphereNode
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()

            // Run the view's session
            sceneView.session.run(configuration)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Pause the view's session
            sceneView.session.pause()
        }

    }
