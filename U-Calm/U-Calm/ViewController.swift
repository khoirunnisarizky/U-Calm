//
//  ViewController.swift
//  U-Calm
//
//  Created by khoirunnisa' rizky noor fatimah on 20/05/19.
//  Copyright © 2019 khoirunnisa' rizky noor fatimah. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer!
    var countNumber : Int = 0
    var totalNumber : Int = 0
    
    @IBOutlet weak var butir1: UIImageView!
    @IBOutlet weak var butir2: UIImageView!
    @IBOutlet weak var butir3: UIImageView!
    @IBOutlet weak var butir4: UIImageView!
    @IBOutlet weak var butir5: UIImageView!
    @IBOutlet weak var butir6: UIImageView!
    @IBOutlet weak var butir7: UIImageView!
    @IBOutlet weak var butir8: UIImageView!
    @IBOutlet weak var butir9: UIImageView!
    @IBOutlet weak var butir10: UIImageView!
    @IBOutlet weak var butir11: UIImageView!
    @IBOutlet weak var butir12: UIImageView!
    @IBOutlet weak var butir13: UIImageView!
    @IBOutlet weak var butir14: UIImageView!
    @IBOutlet weak var butir15: UIImageView!
    @IBOutlet weak var butir16: UIImageView!
    @IBOutlet weak var butir17: UIImageView!
    @IBOutlet weak var butir18: UIImageView!
    @IBOutlet weak var butir19: UIImageView!
    @IBOutlet weak var heartAppeared: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var soundLabel: UIButton!
    
    @IBAction func soundAction(_ sender: Any) {
        if soundLabel.currentImage == UIImage(named: "sounds on") {
            let image = UIImage(named: "no sound")
            soundLabel.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "sounds on")
            soundLabel.setImage(image, for: .normal)
        }
    }
    
    @IBAction func repeatAction(_ sender: Any) {
        countNumber = 0
        totalNumber = 0
        countLabel.text = "\(countNumber)"
        totalLabel.text = "\(totalNumber)"
    }
    
    @IBOutlet weak var bipEveryOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fullAnimation(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tapGesture)
    }
    
    func playSound(selectedSoundFileName : String) {
        let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    func setupCount() {
        let boundNumber = Int(bipEveryOutlet.text!)
        if countNumber < boundNumber! {
            countNumber += 1
        } else {
            countNumber = 1
        }
        totalNumber += 1
        countLabel.text = "\(countNumber)"
        totalLabel.text = "\(totalNumber)"
    }
    
    @objc func fullAnimation(_ sender: UIImageView) {
        setupTasbihAnimation(butirChoosen: butir1)
        setupTasbihAnimation(butirChoosen: butir2)
        setupTasbihAnimation(butirChoosen: butir3)
        setupTasbihAnimation(butirChoosen: butir4)
        setupTasbihAnimation(butirChoosen: butir5)
        setupTasbihAnimation(butirChoosen: butir6)
        setupTasbihAnimation(butirChoosen: butir7)
    
        setupCount()
        
        if soundLabel.currentImage == UIImage(named: "sounds on") {
            playSound(selectedSoundFileName: "tap D-Dzikr")
        }
        let boundNumberVibrate = countLabel.text
        if bipEveryOutlet.text == boundNumberVibrate {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        
    }
    
    
    func setupTasbihAnimation(butirChoosen : UIImageView) {
        let path = UIBezierPath()
        path.move(to: butirChoosen.center)
        //x += 25 dan y += 26 dari objek target pada main.storyboard
        if butirChoosen == butir1 {
            let targetPoint = CGPoint(x: 299, y: 335)
            let controlPoint = CGPoint(x: butir1.frame.midX, y: 298)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        }else if butirChoosen == butir2 {
            let targetPoint = CGPoint(x: 126, y: 335)
            let controlPoint = CGPoint(x: butir2.frame.midX, y: butir2.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir3 {
            let targetPoint = CGPoint(x: 95, y: 361)
            let controlPoint = CGPoint(x: view.frame.width/2, y: 537)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir4 {
            let targetPoint = CGPoint(x: 76, y: 397)
            let controlPoint = CGPoint(x: butir4.frame.midX, y: butir4.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir5 {
            let targetPoint = CGPoint(x: 65, y: 437)
            let controlPoint = CGPoint(x: butir5.frame.midX, y: butir5.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir6 {
            let targetPoint = CGPoint(x: 66, y: 519)
            let controlPoint = CGPoint(x: butir6.frame.midX, y: butir6.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir7 {
            let targetPoint = CGPoint(x: 100, y: 554)
            let controlPoint = CGPoint(x: butir7.frame.midX, y: butir7.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir8 {
            let targetPoint = CGPoint(x: 100, y: 554)
            let controlPoint = CGPoint(x: butir7.frame.midX, y: butir7.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        }
        
        let animation = CAKeyframeAnimation()
        animation.path = path.cgPath
        animation.repeatCount = 0
        animation.duration = 1
        
        //forKey harus position
        butirChoosen.layer.add(animation, forKey: "position")
        //        butirChoosen.center =
        
    }
    
    func fadeOut(){
        UIView.animate(withDuration: 1 , animations: {
            //initial constant
            //scale 2x
            self.heartAppeared.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (isFinished) in
            self.fadeIn()
        }
    }
    func fadeIn(){
        UIView.animate(withDuration: 1, animations: {
            // balikin ke size semula
            self.heartAppeared.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (isFinished) in
//            self.fadeOut()
        }
    
    

}

}
