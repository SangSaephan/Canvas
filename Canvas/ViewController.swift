//
//  ViewController.swift
//  Canvas
//
//  Created by Sang Saephan on 3/15/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newCreatedFace: UIImageView!
    var faceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayCenterWhenOpen = trayView.center
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + 175)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
         
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            //trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                })
            }
            if velocity.y < 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                })
            }
        } else if sender.state == .ended {
            print("Ended")
        }
    }
    
    @IBAction func onSmileyPanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            var imageView = sender.view as? UIImageView
            self.newCreatedFace = UIImageView(image: imageView?.image)
            self.view.addSubview(self.newCreatedFace)
            self.newCreatedFace.center = (imageView?.center)!
            
            let faceCenter = self.newCreatedFace.center
            self.newCreatedFace.center = CGPoint(x: faceCenter.x, y: faceCenter.y + trayView.frame.origin.y)
            faceOriginalCenter = newCreatedFace.center
        } else if sender.state == .changed {
            newCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: faceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            
        }
    }

}

