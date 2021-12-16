//
//  ViewController.swift
//  multiple-objects
//
//  Created by Ramarao Manohar on 16/12/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        self.sceneView.scene.rootNode.addChildNode(getBoxNode())
        self.sceneView.scene.rootNode.addChildNode(getSphere())
        
    }
    
    func getBoxNode() -> SCNNode{
        
        // create geometric shape
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        
        // add materials
        box.firstMaterial?.diffuse.contents = UIImage(named: "wood.jpeg")
        
        // create node for the shape
        let boxNode = SCNNode(geometry: box)
        
        // decide the position
        boxNode.position = SCNVector3(0, 0, -0.5)
        
        // return the node
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
