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
            clearLayout()
            setLayout(layout)
            setButtonLayout(layout)
        }
    }
    
    @IBOutlet private weak var Layout1Button: UIButton!
    @IBOutlet private weak var Layout2Button: UIButton!
    @IBOutlet private weak var Layout3Button: UIButton!

    @IBOutlet private weak var Layout1: UIView!
    @IBOutlet private weak var Layout2: UIView!
    @IBOutlet private weak var Layout3: UIView!

    @IBOutlet var ImageView: [UIImageView]!

    private func clearLayout() {
        for view in ImageView {
            view.contentMode = .center
            view.image = UIImage(named: "AddButton")
            
        
            
        }
    }

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
        
        Layout1.isHidden = true
        Layout2.isHidden = true
        Layout3.isHidden = true
        
        switch layout {
        case .oneTopAndTwoBottom: // BigTop, BottomLeft, BottomRight
            Layout1.isHidden = false
        case .twoTopAndOneBottom: // BigBottom, TopLeft, TopRight
            Layout2.isHidden = false
        case .twoTopAndTwoBottom: // TopLeft, topRight, BottomLeft, BottomRight
            Layout3.isHidden = false
        }
    }

}
