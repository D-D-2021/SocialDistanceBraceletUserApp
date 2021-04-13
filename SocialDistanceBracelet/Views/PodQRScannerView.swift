//
//  PodQRScannerView.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/12/21.
//

import UIKit
import AVFoundation

class PodQRScannerView: UIView {
    
    var captureSession:AVCaptureSession?
    var capturePhotoOutput:AVCapturePhotoOutput?
    var delegate:AVCaptureMetadataOutputObjectsDelegate
    
    init(captureDelegate: AVCaptureMetadataOutputObjectsDelegate, frame:CGRect) {
        delegate = captureDelegate
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let bgView = UIView(frame: rect)
        bgView.backgroundColor = UIColor(ciColor: CIColor.init(red: 32/255, green: 58/255, blue: 67/255))
        self.addSubview(bgView)
        
        
        let videoPreviewView = UIView(frame: CGRect(x: rect.minX + 10, y: rect.minY + 10, width: rect.width - 20, height: rect.height - 20))
        
        
        self.addSubview(videoPreviewView)
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        
        //MARK: QR scanning logic
        var videoLayer = AVCaptureVideoPreviewLayer()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            
            captureSession?.addInput(input)
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
            captureSession?.addOutput(capturePhotoOutput!)
            
            captureSession?.sessionPreset = .high
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoLayer.videoGravity = .resizeAspectFill
            videoLayer.frame = videoPreviewView.layer.bounds
            
            videoPreviewView.layer.addSublayer(videoLayer)
            captureSession!.startRunning()
        }
        
        catch {
            print(error)
            return
        }
        
    }
    
    
    func stopScanning() {
        captureSession?.stopRunning()
    }

}
