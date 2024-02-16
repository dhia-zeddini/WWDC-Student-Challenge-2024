//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 15/2/2024.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

class CustomARView: ARView{
    
    var currentEntity: ModelEntity?
       required init(frame frameRect: CGRect) {
           super.init(frame: frameRect)
           setupGestures()
       }
       
       required init?(coder decoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       convenience init() {
           self.init(frame: UIScreen.main.bounds)
           subscribeToActionStream()
       }
       
       private func setupGestures() {
           let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
           self.addGestureRecognizer(pinchGesture)
           
           let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
           self.addGestureRecognizer(panGesture)
           
           let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
           self.addGestureRecognizer(rotationGesture)

       }
       @objc private func handlePinch(_ sender: UIPinchGestureRecognizer) {
           guard let entity = currentEntity else { return }
           
           if sender.state == .changed {
               let scale = sender.scale
               entity.scale *= Float(scale)
               sender.scale = 1.0 // Reset the scale so that the pinch is relative to the new size
           }
       }
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self)
        
        switch sender.state {
        case .began, .changed:
            guard let hitTestResult = self.hitTest(location, types: [.existingPlaneUsingExtent]).first else { return }
            
            print(hitTestResult.type)
            // Convert the hit test result into a world position
            let worldTransform = hitTestResult.worldTransform
            let newPosition = SIMD3<Float>(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
            
            // Update the position of the current entity
            currentEntity?.position = newPosition
        default:
            break
        }
    }

    @objc private func handleRotation(_ sender: UIRotationGestureRecognizer) {
        guard let entity = currentEntity else { return }
        
        if sender.state == .changed {
            // Y-axis rotation
            let rotationY = simd_quatf(angle: Float(sender.rotation), axis: SIMD3<Float>(0, 0, 1))
            entity.orientation = rotationY * entity.orientation
            sender.rotation = 0
        }
    }


       func placeBlock(ofColor color: Color) {
           let block = MeshResource.generateBox(size: 0.3)
           let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
           let entity = ModelEntity(mesh: block, materials: [material])
           entity.name = "\(color)"
           
           let anchor = AnchorEntity(plane: .horizontal)
           anchor.addChild(entity)
           scene.addAnchor(anchor)
           
           // Keep a reference to the current entity to resize it later
           currentEntity = entity

          
       }
    private var cancellables: Set<AnyCancellable> = []
    func subscribeToActionStream(){
        ARManager.shared
            .actionStream
            .sink{ [weak self] action in
                switch action{
                case .placeBlock(let color):
                    self?.placeBlock(ofColor: color)
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func configurationExamples(){
        
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
        
        let _ = ARGeoTrackingConfiguration()
        //tracks faces in the scene
        let _ = ARFaceTrackingConfiguration()
        //trackes bodies in the scene
        let _ = ARBodyTrackingConfiguration()
    }
    
    func anchorExemples(){
        //attach anchors to specific coordinates in the iphone-centered coordinate system
        let coordinateAnchor = AnchorEntity(world: .zero)
        
        //attach anchors to detected planes
        let _ = AnchorEntity(plane: .horizontal)
        let _ = AnchorEntity(plane: .vertical)
        //attach anchors to tracked body parts (ex: face)
        let _ = AnchorEntity(.face)
        //attach anchors to tracked images
        let _ = AnchorEntity(.image(group: "groupe", name: "name"))
        
        //add anchor to the scene
        scene.addAnchor(coordinateAnchor)
    }
    
    func entityExemples(){
        //load an entity from usdz file
        let _ = try? Entity.load(named: "usdzFilename")
        
        //load an entity from reality file
        let _ = try? Entity.load(named: "realityFilename")
        
        let box = MeshResource.generateBox(size: 1)
        let entity = ModelEntity(mesh: box)
        
        //add entity to an anchor
        let anchor = AnchorEntity()
        anchor.addChild(entity)
        
    }
    
   /* func placeBlock(ofColor color: Color){
        let block = MeshResource.generateBox(size: 0.3)
        let material = SimpleMaterial(color: UIColor(color) ,isMetallic: false)
        let entity = ModelEntity(mesh: block,materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }*/
    
}
