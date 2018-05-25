//
//  Layout.swift
//  P5
//
//  Created by De knyf Gregory on 21/05/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation
import UIKit

class TransformView{

    static func toImage(mainLayout: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(mainLayout.bounds.size, mainLayout.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            mainLayout.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
