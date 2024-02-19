import ARKit
import RealityKit
import SwiftUI
import Combine
import FocusEntity

class CustomARView: ARView{
    private var cancellables: Set<AnyCancellable> = []
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect){
        super.init(frame: frameRect)
    }
    
     dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        self.setUpARView()
        self.setUpFocusEntity()
        subscribeToActionStream()
    }
    
    func setUpARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }

        self.session.run(config)
    }
    func setUpFocusEntity() {
        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))
    }
    func setupGestures(on object:ModelEntity){
          object.generateCollisionShapes(recursive: true)
        self.installGestures([.scale,.rotation,.all],for: object)
      }
   
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
        guard let focusEntity = self.focusEntity else { return }

        let modelEntity = try! Entity.load(named: "pet_house")
       // let texture = try! TextureResource.load(named: "petHouseTexture")
      //  modelEntity.
        let anchorEntity = AnchorEntity(world: focusEntity.position)
        anchorEntity.addChild(modelEntity)
        scene.addAnchor(anchorEntity)
    }
}

