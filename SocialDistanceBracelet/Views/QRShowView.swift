//
//  QRShowView.swift
//  SocialDistanceBracelet
//
//  Created by Aryeh Greenberg on 4/11/21.
//

import UIKit

class QRShowView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let bgView = UIView(frame: rect)
        bgView.backgroundColor = UIColor(ciColor: CIColor.init(red: 32/255, green: 58/255, blue: 67/255))
        self.addSubview(bgView)
        
        
        let imageView = UIImageView(frame: CGRect(x: rect.minX + 10, y: rect.minY + 10, width: rect.width - 20, height: rect.height - 20))
        imageView.image = generateQRCode(from: UserDefaults.standard.string(forKey: "USER_ID") ?? "We have an issue")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        self.addSubview(imageView)
        
        
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }

}
