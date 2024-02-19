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
    func setupGestures(on object:ModelEntity){
          object.generateCollisionShapes(recursive: true)
        self.installGestures([.scale,.rotation,.all],for: object)
      }
    private var cancellables: Set<AnyCancellable> = []
    func subscribeToActionStream(){
        ARManager.shared
            .actionStream
            .sink{ [weak self] action in
                switch action{
                case .placeBlock(let color):
                    self?.placeBlock(ofColor: color)
                case .beer:
                    self?.placeBeer()
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    

    
    func placeBlock(ofColor color: Color){
        let block = MeshResource.generateBox(size: 0.3)
        let material = SimpleMaterial(color: UIColor(color) ,isMetallic: false)
        let entity = ModelEntity(mesh: block,materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
        setupGestures(on: entity)
    }
    func placeBeer(){
    
        let entity = try? Entity.load(named: "pet_house")
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity!)
        scene.addAnchor(anchor)
        //setupGestures(on: entity)
    }
}

