//
//  PodViewController.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/5/21.
//

import UIKit
import AVFoundation
import ProgressHUD


class PodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate {

    var qrView:QRShowView?
    var qrScannerView:PodQRScannerView?
    
    var userPodsMembers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.colorHUD = .white

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Scan QR", style: .plain, target: self, action: #selector(PodViewController.scanQR))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Show QR", style: .plain, target: self, action: #selector(PodViewController.showQR))
    }
    @IBOutlet weak var tableView: UITableView!
    
    @objc func showQR() {
        if qrView == nil {
            hideQRScannerView()
            UserDefaults.standard.setValue("abcde", forKey: "USER_ID")
            qrView = QRShowView(frame: CGRect(x: self.view.center.x - 100, y: self.view.center.y - 100, width: 200, height: 200))
            self.view.addSubview(qrView!)
            
            self.navigationItem.leftBarButtonItem?.title = "Hide QR"
        }
        
        else {
            hideQRView()
        }
    }
    
    
    @objc func scanQR() {
        if qrScannerView == nil {
            hideQRView()
            qrScannerView = PodQRScannerView(captureDelegate: self, frame: CGRect(x: self.view.center.x - 100, y: self.view.center.y - 100, width: 200, height: 200))
            self.view.addSubview(qrScannerView!);
            self.navigationItem.rightBarButtonItem?.title = "Hide QR Scanner"
        }
        
        else {
            hideQRScannerView()
        }
    }
    
    func hideQRView() {
        if qrView != nil {
            qrView?.removeFromSuperview()
            qrView = nil
            self.navigationItem.leftBarButtonItem?.title = "Show QR"
        }
    }
    
    /**
     * Hide the QR scanner view
     */
    func hideQRScannerView() {
        if qrScannerView != nil {
            qrScannerView?.stopScanning()
            qrScannerView?.removeFromSuperview()
            qrScannerView = nil
            self.navigationItem.rightBarButtonItem?.title = "Scan QR"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPodsMembers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podMember") as! PodMemberTableViewCell
        cell.weirdLabel.text = userPodsMembers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.userPodsMembers.remove(at: indexPath.row)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .middle)
            }
            completionHandler(true)
        }
        
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            return;
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == .qr {
            if let outputString = metadataObj.stringValue {
                addUserWithData(data: outputString)
            }
        }
    }
    
    func addUserWithData(data:String) {
        hideQRScannerView()
        
        userPodsMembers.append(data)
        
        ProgressHUD.show()
        perform(#selector(completeUserAddition), with: nil, afterDelay: 2)
    }
    
    @objc func completeUserAddition() {
        ProgressHUD.showSuccess()
        
        tableView.reloadData()
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
