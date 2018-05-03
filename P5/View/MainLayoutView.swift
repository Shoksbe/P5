//
//  MainLayoutView.swift
//  P5
//
//  Created by De knyf Gregory on 30/04/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class MainLayoutView: UIView {
    
    enum Layout {
        case oneTopAndTwoBottom, twoTopAndOneBottom, twoTopAndTwoBottom
    }
    
    var layout: Layout = .twoTopAndOneBottom {
        didSet {
            setLayout(layout)
            setButtonLayout(layout)
        }
    }
    
    @IBOutlet weak var Layout1Button: UIButton!
    @IBOutlet weak var Layout2Button: UIButton!
    @IBOutlet weak var Layout3Button: UIButton!


    private func setButtonLayout(_ layout: Layout) {
        //Remove mask "Selected"
        Layout1Button.setImage(nil, for: .normal)
        Layout2Button.setImage(nil, for: .normal)
        Layout3Button.setImage(nil, for: .normal)
        
        //Add mask button of the layout
        switch layout {
            
        case .oneTopAndTwoBottom: // BigTop, BottomLeft, BottomRight
            Layout1Button.setImage(UIImage(named: "Selected"), for: .normal)

        case .twoTopAndOneBottom: // BigBottom, TopLeft, TopRight
            Layout2Button.setImage(UIImage(named: "Selected"), for: .normal)
            
        case .twoTopAndTwoBottom: // TopLeft, topRight, BottomLeft, BottomRight
            Layout3Button.setImage(UIImage(named: "Selected"), for: .normal)
        }
    }
    
    private func setLayout(_ layout: Layout) {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }

        switch layout {
        case .oneTopAndTwoBottom: // BigTop, BottomLeft, BottomRight
            
            //BigTop
            let bigTop = UIImageView(frame: CGRect(x: 15, y: 15, width: 270, height: 127.5))
            bigTop.backgroundColor = UIColor.white
            
            //BottomLeft
            let bottomLeft = UIImageView(frame: CGRect(x: 15, y: 157.5, width: 127.5, height: 127.5))
            bottomLeft.backgroundColor = UIColor.white
            
            //BottomRight
            let bottomRight = UIImageView(frame: CGRect(x: 157.5, y: 157.5, width: 127.5, height: 127.5))
            bottomRight.backgroundColor = UIColor.white

            // Add UIView as a Subview
            self.addSubview(bigTop)
            self.addSubview(bottomLeft)
            self.addSubview(bottomRight)

        case .twoTopAndOneBottom: // BigBottom, TopLeft, TopRight
            
            //BigBottom
            let bigBottom = UIImageView(frame: CGRect(x: 15, y: 157.5, width: 270, height: 127.5))
            bigBottom.backgroundColor = UIColor.white
            
            //TopLeft
            let topLeft = UIImageView(frame: CGRect(x: 15, y: 15, width: 127.5, height: 127.5))
            topLeft.backgroundColor = UIColor.white
            
            //TopRight
            let topRight = UIImageView(frame: CGRect(x: 157.5, y: 15, width: 127.5, height: 127.5))
            topRight.backgroundColor = UIColor.white
            
            // Add UIView as a Subview
            self.addSubview(bigBottom)
            self.addSubview(topLeft)
            self.addSubview(topRight)

        case .twoTopAndTwoBottom: // TopLeft, topRight, BottomLeft, BottomRight
            
            //TopLeft
            let topLeft = UIImageView(frame: CGRect(x: 15, y: 15, width: 127.5, height: 127.5))
            topLeft.backgroundColor = UIColor.white
            
            //TopRight
            let topRight = UIImageView(frame: CGRect(x: 157.5, y: 15, width: 127.5, height: 127.5))
            topRight.backgroundColor = UIColor.white
            
            //BottomLeft
            let bottomLeft = UIImageView(frame: CGRect(x: 15, y: 157.5, width: 127.5, height: 127.5))
            bottomLeft.backgroundColor = UIColor.white
            
            //BottomRight
            let bottomRight = UIImageView(frame: CGRect(x: 157.5, y: 157.5, width: 127.5, height: 127.5))
            bottomRight.backgroundColor = UIColor.white
            
            // Add UIView as a Subview
            self.addSubview(topLeft)
            self.addSubview(topRight)
            self.addSubview(bottomLeft)
            self.addSubview(bottomRight)
        }
    }

}
