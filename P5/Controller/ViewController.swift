//
//  ViewController.swift
//  P5
//
//  Created by De knyf Gregory on 30/04/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default layout
        mainLayoutView.layout = .twoTopAndOneBottom
        
        //
        //GESTURE FOR CHOOSE PICTURE
        //
        
        //Browse all the views that can receive a photo in mainViewLayout to add the gestures.
        for view in mainLayoutView.ImageView {
            //GestureRecognizer to be able to click on the layout where the user wants to add a photo
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImage(_:)))
            //Enabling user interaction on the layout
            view.isUserInteractionEnabled = true
            //Add gesture's layout
            view.addGestureRecognizer(tapGestureRecognizer)
        }
        
        //
        //GESTURE FOR SHARE INSTAGRID
        //
        
        //GestureRecognizer to share the photo
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragLayout(_:)))
        //add gesture's layout
        mainLayoutView.addGestureRecognizer(panGestureRecognizer)
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        currentImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func setImage(_ sender: UITapGestureRecognizer) {
        
        //
        //Background image option
        //
        currentImageView = sender.view as! UIImageView
        
        currentImageView.clipsToBounds = true
        currentImageView.contentMode = .scaleAspectFill
        
        //
        //PickerController settings
        //
        let imageController = UIImagePickerController()
        
        imageController.delegate = self
        imageController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imageController, animated: true, completion: nil)
    }
    
    @objc func dragLayout(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformLayoutViewWith(gesture: sender)
        default:
            break
        }
    }
    
    private func transformLayoutViewWith(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: mainLayoutView)
        
        //Landscape orientation
        //Translation only on Leftside
        if DeviceInfo.Orientation.isLandscape {
            if translation.x < 0 {
                mainLayoutView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        }
        //Portrait orientation
        //Translation only on Upside
        if DeviceInfo.Orientation.isPortrait {
            if translation.y < 0 {
                mainLayoutView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        }
    }
    
    struct DeviceInfo {
        struct Orientation {
            // indicate current device is in the LandScape orientation
            static var isLandscape: Bool {
                get {
                    return UIDevice.current.orientation.isValidInterfaceOrientation
                        ? UIDevice.current.orientation.isLandscape
                        : UIApplication.shared.statusBarOrientation.isLandscape
                }
            }
            // indicate current device is in the Portrait orientation
            static var isPortrait: Bool {
                get {
                    return UIDevice.current.orientation.isValidInterfaceOrientation
                        ? UIDevice.current.orientation.isPortrait
                        : UIApplication.shared.statusBarOrientation.isPortrait
                }
            }
        }}
}

