//
//  ViewController.swift
//  VDSSwipingCollectionView
//
//  Created by Vimal Das on 10/12/18.
//  Copyright © 2018 Vimal Das. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var swipeView: VDSSwipeView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = self.storyboard?
            .instantiateViewController(withIdentifier: "2") as! ViewController2
        let vc2 = self.storyboard?
            .instantiateViewController(withIdentifier: "3") as! ViewControlle3
        
        swipeView.setup(in: self, withTitles: ["Swipe", ":D"], ofViewControllers: [vc1, vc2])
    }
}

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let vc = self.storyboard?
            .instantiateViewController(withIdentifier: "4") as! ViewControlle4
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
class ViewControlle3: UIViewController {
    
     override func viewDidLoad() {
           super.viewDidLoad()
           
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
           self.view.addGestureRecognizer(tapGesture)
       }
       
       @objc func tapped(sender: UITapGestureRecognizer) {
           let vc = self.storyboard?
               .instantiateViewController(withIdentifier: "5") as! ViewControlle5
           vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true, completion: nil)
       }
    
}

class ViewControlle4: UIViewController {
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
           self.view.addGestureRecognizer(tapGesture)
       }
       
       @objc func tapped(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
       }
    
    
}

class ViewControlle5: UIViewController {
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
           self.view.addGestureRecognizer(tapGesture)
       }
       
       @objc func tapped(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
       }
    
    
}
