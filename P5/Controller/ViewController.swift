//
//  ViewController.swift
//  P5
//
//  Created by De knyf Gregory on 30/04/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    
    ///Contains the layout chosen by the user during UITapGesture
    var currentImageView: UIImageView!

    //
    // MARK: Outlets
    //
    
    ///This view contains all layouts for photos
    @IBOutlet weak var mainLayoutView: MainLayoutView!
    
    
    //
    // MARK: Actions
    //
    
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
            if isCorrectPositionForSharing(gesture: sender) {
                shareLayout()
            } else {
                transformLayoutToIdentity()
            }
        default:
            break
        }
    }
    
    
    //
    // MARK: Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default layout at launch
        mainLayoutView.layout = .twoTopAndOneBottom
    }
    
    /// Activate the user-selected layout
    ///
    /// - Parameter selectedButtonTag: button's tag
    private func changeLayout(_ selectedButtonTag: Int) {
        
        //
        //View disappear
        //
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mainLayoutView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { (success) in
            
            if success {
                
                //
                //Change layout
                //
                
                //get the button tag to identify the layout
                switch selectedButtonTag {
                case 1: // BigTop, BottomLeft, BottomRight
                    self.mainLayoutView.layout = .oneTopAndTwoBottom
                case 2: // BigBottom, TopLeft, TopRight
                    self.mainLayoutView.layout = .twoTopAndOneBottom
                case 3: // TopLeft, topRight, BottomLeft, BottomRight
                    self.mainLayoutView.layout = .twoTopAndTwoBottom
                default:
                    break
                }

                //
                //View appear
                //
                
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.mainLayoutView.transform = .identity
                }, completion:nil)
            }
        })
    }

    
    /// Move the view by following the user's finger.
    ///
    /// - Parameter gesture: PanGesture ctivate by the user
    private func transformLayoutViewWith(gesture: UIPanGestureRecognizer) {

        //Get the finger position on the screen
        let translation = gesture.translation(in: mainLayoutView)
        
        //Landscape orientation
        //Translation only on Leftside
        if UIApplication.shared.statusBarOrientation.isLandscape {
            if translation.x < 0 {
                mainLayoutView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            }
        }
        
        
        //Portrait orientation
        //Translation only on Upside
        if UIApplication.shared.statusBarOrientation.isPortrait {
            if translation.y < 0 {
                mainLayoutView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        }
    }
    
    
    /// Check if the view position has exceeded at least half the distance to the top of the screen in *portrait* and to the left in *landscape* mode.
    ///
    /// - Parameter gesture: View's position
    /// - Returns: *True* if the position is correct and *false* otherwise.
    private func isCorrectPositionForSharing(gesture: UIPanGestureRecognizer)-> Bool {
        
        var isCorrectPosition: Bool = false
        
        //Get the finger position on the screen
        let translation = gesture.translation(in: mainLayoutView)
        
        //Get the screenSize for the belowing condition
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        
        /**
         The following two conditions only enable sharing if
         the view has exceeded more than half the
         distance to the edge of the screen.
        */
        
        //Landscape orientation
        if UIApplication.shared.statusBarOrientation.isLandscape {
            if translation.x < -(screenWidth/4) {
                
                //Send layout outside screen "LEFT"
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainLayoutView.transform =  CGAffineTransform(translationX: -screenWidth, y: 0)
                })
                
                isCorrectPosition = true
            }
        }
        
        //Portrait orientation
        if UIApplication.shared.statusBarOrientation.isPortrait {
            if translation.y < -(screenHeight/4) {
                
                //Send layout outside screen "UP"
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainLayoutView.transform =  CGAffineTransform(translationX: 0, y: -screenHeight)
                })
                
                isCorrectPosition = true
            }
        }
        
        return isCorrectPosition
    }
    
    /// Return the view to the initial position
    private func transformLayoutToIdentity(){
        //Layout return to identity with a "Boing" effect
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.mainLayoutView.transform = .identity
        }, completion:nil)
    }
    
    
    //
    // MARK: PickerController
    //
    
    /// Activate the pickerController to add an image in the chosen layout.
    ///
    /// - Parameter sender: The view clicked by the user
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
    
    
    //
    // MARK: ActivityController
    //
    
    /// Convert the view in imageView and lunch activityController for sharing the picture
    private func shareLayout() {
                
        //Transformation of UIView into UIImage
        if let imageToShare = TransformView.toImage(mainLayout: mainLayoutView) {
            
            //Creation and display of the UIActivityController
            let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
                        
            activityVC.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed || completed {
                    self.transformLayoutToIdentity()
                }
            }
        }
    }
}

