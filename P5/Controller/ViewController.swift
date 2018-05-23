//
//  ViewController.swift
//  P5
//
//  Created by De knyf Gregory on 30/04/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default layout
        mainLayoutView.layout = .twoTopAndOneBottom

        layout = LayoutSettings(layout: mainLayoutView)
    }

    //This view contains layouts for photos
    @IBOutlet weak var mainLayoutView: MainLayoutView!
    
    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        changeLayout(sender.tag)
    }
    @IBAction func didTapLayout(_ sender: UITapGestureRecognizer) {
        addImage(in: sender)
    }
    @IBAction func dragLayout(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformLayoutViewWith(gesture: sender)
        case .cancelled, .ended:
            transformLayoutToIdentity {
                shareLayout()
            }
        default:
            break
        }
    }
    
    //Activates the layout chooses via the button
    private func changeLayout(_ selectedButtonTag: Int) {
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

    private func transformLayoutViewWith(gesture: UIPanGestureRecognizer) {

        //Get the finger position on the screen
        let translation = gesture.translation(in: mainLayoutView)
        
        //Landscape orientation
        //Translation only on Leftside
        if DeviceInfo.Orientation.isLandscape {
            if translation.x < 0 && translation.x > -30  {
                mainLayoutView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        }
        //Portrait orientation
        //Translation only on Upside
        if DeviceInfo.Orientation.isPortrait {
            if translation.y < 0 && translation.y > -30 {
                mainLayoutView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        }
    }
    
    private func shareLayout() {
        //Transformation of UIView into UIImage
        if let imageToShare = layout.toImage() {
            //Creation and display of the UIActivityController
            let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func transformLayoutToIdentity(completion: () -> ()) {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.mainLayoutView.transform = .identity
        }, completion:nil)
        completion()
    }

    private func addImage(in sender: UITapGestureRecognizer) {

        //save the selected layout to put the chosen photo
        currentImageView = sender.view as! UIImageView

        //
        //PickerController settings
        //
        let imageController = UIImagePickerController()
        imageController.delegate = self

        //Selection of the source of photos, here it will be the library but it can also be the camera.
        imageController.sourceType = .photoLibrary

        //present the pickerController for choos a image
        self.present(imageController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        //Save image choosen by the user
        let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage

        //Some image's option
        currentImageView.clipsToBounds = true
        currentImageView.contentMode = .scaleAspectFill

        //Affect image choosen by the user on the layout
        currentImageView.image = choosenImage

        //Close pickerController
        self.dismiss(animated: true, completion: nil)
    }

    private struct DeviceInfo {
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
        }
    }
}

