//
//  MainLayoutView.swift
//  P5
//
//  Created by De knyf Gregory on 30/04/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class MainLayoutView: UIView {

    @IBOutlet weak var Layout1Button: UIButton!
    @IBOutlet weak var Layout2Button: UIButton!
    @IBOutlet weak var Layout3Button: UIButton!

    @IBAction func ActiveLayout(_ sender: UIButton) {

        removeMaskSelected()

        switch sender.tag {
        case 1:
            Layout1Button.setImage(UIImage(named: "Selected"), for: .normal)

        case 2:
            Layout2Button.setImage(UIImage(named: "Selected"), for: .normal)

        case 3:
            Layout3Button.setImage(UIImage(named: "Selected"), for: .normal)

        default:
            break
        }
    }


    func removeMaskSelected(){
        Layout1Button.setImage(nil, for: .normal)
        Layout2Button.setImage(nil, for: .normal)
        Layout3Button.setImage(nil, for: .normal)
    }

}
