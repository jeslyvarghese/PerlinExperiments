//
//  ViewController.swift
//  PerlinExperiments
//
//  Created by Jesly Varghese on 18/01/20.
//  Copyright © 2020 Jesly Varghese. All rights reserved.
//

import UIKit
import SceneKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let scene = SCNScene()
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3Make(0, 5, 15)
        
        let groundNode = SCNNode()
        groundNode.position = SCNVector3(0, 0, 0)
        let groundGeometry = perlinPlane()
        groundGeometry.firstMaterial?.diffuse.contents = UIColor.red
        groundNode.geometry = groundGeometry
        scene.rootNode.addChildNode(groundNode)
        
        let scnView = SCNView()
        scnView.pointOfView = cameraNode
        scnView.allowsCameraControl = true
        scnView.scene = scene
        view.addSubview(scnView)
        scnView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(scnView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        view.addConstraint(scnView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        view.addConstraint(scnView.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(scnView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}

