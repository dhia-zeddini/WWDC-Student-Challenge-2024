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
    
    required init(frame frameRect: CGRect){
        super.init(frame: frameRect)
    }
    
     dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    func subscribeToActionStream(){
        ARManager.shared
            .actionStreem
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
    
    func placeBlock(ofColor color: Color){
        let block = MeshResource.generateBox(size: 0.3)
        let material = SimpleMaterial(color: UIColor(color) ,isMetallic: false)
        let entity = ModelEntity(mesh: block,materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }
    
}
