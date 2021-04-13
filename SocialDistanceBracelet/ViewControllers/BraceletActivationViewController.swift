//
//  BraceletActivationViewController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/1/21.
//

import UIKit
import TextFieldEffects
import ProgressHUD
import AVFoundation

class BraceletActivationViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var videoPreviewView: UIView!
    @IBOutlet weak var braceletImage: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    var captureSession:AVCaptureSession?
    var capturePhotoOutput:AVCapturePhotoOutput?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var videoLayer = AVCaptureVideoPreviewLayer()

        // Do any additional setup after loading the view.
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.colorHUD = .white
        
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
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoLayer.videoGravity = .resizeAspectFill
            videoLayer.frame = videoPreviewView.layer.bounds
            
            videoPreviewView.layer.addSublayer(videoLayer)
            
            captureSession?.startRunning()
        }
        
        catch {
            print(error)
            return
        }
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            return;
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == .qr {
            if let outputString = metadataObj.stringValue {
                print(outputString)
                activateWithId(id: outputString)
            }
        }
    }
    
    @IBAction func braceletIdDone(_ sender: Any) {
        print("Entered")
        idTextField.resignFirstResponder()
    }
    
    @IBAction func activate(_ sender: Any) {
        activateWithId(id: idTextField.text ?? "")
    }
    
    func activateWithId(id: String) {
        captureSession?.stopRunning()
        videoPreviewView.isHidden = true
        ProgressHUD.show()
        perform(#selector(moveForwards), with: nil, afterDelay: 2)
    }
    
    @objc func moveForwards() {
        ProgressHUD.showSuccess()
        perform(#selector(nextScreen), with: nil, afterDelay: 1)
    }
    
    @objc func nextScreen() {
        print("Next")
        
        let formView = storyboard?.instantiateViewController(identifier: "tabBarController")
        self.present(formView!, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
