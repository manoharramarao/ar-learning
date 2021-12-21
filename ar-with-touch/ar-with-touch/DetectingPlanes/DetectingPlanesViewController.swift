//
//  DetectingPlanesViewController.swift
//  ar-with-touch
//
//  Created by Ramarao Manohar on 17/12/21.
//

import UIKit
import SceneKit
import ARKit

class DetectingPlanesViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    private let label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.frame = CGRect(x: 0, y: 0, width: self.sceneView.frame.size.width, height: 44)
        self.label.center = self.sceneView.center
        self.label.textAlignment = .center
        self.label.textColor = UIColor.white
        self.label.alpha = 0
        
        self.sceneView.addSubview(self.label)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            self.label.text = "Plane Detected"
            
            UIView.animate(withDuration: 3.0, animations: {
                self.label.alpha = 1.0
            }) { (completion: Bool) in
                self.label.alpha = 0.0
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}
