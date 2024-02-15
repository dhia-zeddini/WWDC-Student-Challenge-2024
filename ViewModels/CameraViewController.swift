import AVFoundation
import UIKit

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var previewLayer: AVCaptureVideoPreviewLayer?
    let captureSession = AVCaptureSession()  // Make captureSession an instance property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
    }
    
    private func setupCameraSession() {
        captureSession.sessionPreset = .high
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                fatalError("Cannot add video input")
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.frame = view.bounds
            previewLayer?.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer!)
            
            // Setup video output
            setupVideoOutput()
            
            captureSession.startRunning()
        } catch {
            print(error)
            return
        }
    }
    
    func setupVideoOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
    }
    
    // Delegate method from AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Here you can process each frame in your ML model
    }
}
