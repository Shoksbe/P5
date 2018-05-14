//
//  ViewController.swift
//  P5
//
//  Created by De knyf Gregory on 30/04/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        mainLayoutView.layout = .twoTopAndOneBottom
    }
    
    //This view contains layouts for photos
    @IBOutlet weak var mainLayoutView: MainLayoutView!
    
    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        setLayout(sender.tag)
    }
    
    //Activates the layout chooses via the button
    private func setLayout(_ selectedButtonTag: Int) {
        //get the button tag to identify the layout
        switch selectedButtonTag {
        case 1: // BigTop, BottomLeft, BottomRight
            mainLayoutView.layout = .oneTopAndTwoBottom
        case 2: // BigBottom, TopLeft, TopRight
            mainLayoutView.layout = .twoTopAndOneBottom
        case 3: // TopLeft, topRight, BottomLeft, BottomRight
            mainLayoutView.layout = .twoTopAndTwoBottom
        default:
            break
        }
    }
}

