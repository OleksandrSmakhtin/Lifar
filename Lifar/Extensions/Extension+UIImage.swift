//
//  Extension+UIImage.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 18.06.2023.
//

import Foundation
import UIKit

extension UIImage {
    func rotate(degrees: CGFloat) -> UIImage? {
        let radians = degrees * CGFloat.pi / 180.0
        let rotatedSize = CGSize(width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(rotatedSize)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        context.rotate(by: radians)
        self.draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
}


