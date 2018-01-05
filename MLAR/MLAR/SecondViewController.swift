//
//  SecondViewController.swift
//  MLAR
//
//  Created by Pranav Raikundalia on 11/20/17.
//  Copyright © 2017 Hardik Shah. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class SecondViewController: UIViewController, ARSCNViewDelegate {
    
    

    var object = String()
    
    @IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate=self
        let text=SCNText(string: self.object, extrusionDepth: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        text.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(x: 0.0, y: -1.0, z: -1)
        node.scale = SCNVector3(x: 0.01, y: 0.02, z: 0.03)
        node.geometry = text
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting=true
        // Do any additional setup after loading the view.
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
