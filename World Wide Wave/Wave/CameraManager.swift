//
//  CameraManager.swift
//  World Wide Wave
//
//  Created by Ryutarou Nakajima on 2024/12/30.
//

import SwiftUI
import AVFoundation

actor CameraManager {
    func requestCameraAccess() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
            return false
        }
    }
}
struct CameraPreviewView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraPreviewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class CameraPreviewController: UIViewController {
    private let session = AVCaptureSession()
    private let videoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
        setupPreviewLayer()
    }
    
    private func setupCameraSession() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            print("failed to load camera")
            return
        }
        
        session.addInput(input)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    private func setupPreviewLayer() {
        videoPreviewLayer.session = session
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer)
    }
}
