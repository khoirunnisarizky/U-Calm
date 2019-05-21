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
struct publicData{
    static var counter : Int = 1
}

class ViewController: UIViewController, AVAudioPlayerDelegate, UITextFieldDelegate {

    var audioPlayer : AVAudioPlayer!
    var countNumber : Int = 0
//    var totalNumber : Int = 0
    var bipTextField = UITextField()
    var bipEvery : String = ""
    
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
    @IBOutlet weak var slashOutlet: UILabel!
    
    @IBOutlet weak var countBip: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
//    @IBOutlet weak var totalLabel: UILabel!
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
//        totalNumber = 0
        countLabel.text = "\(countNumber)"
        playSound(selectedSoundFileName: "repeat sound")
//        totalLabel.text = "\(totalNumber)"
    }
    
    @IBAction func bipEveryButton(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) -> Void in
            self.bipTextField = textField
            self.bipTextField.delegate = self //REQUIRED
            self.bipTextField.placeholder = "Bip every"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
            publicData.counter = Int(self.bipTextField.text ?? "1") ?? 1
            self.bipEvery = self.bipTextField.text!
            self.countBip.text = String(publicData.counter)
        }))
        
        present(alert, animated: true, completion: nil)
        countLabel.text = "0"
        countNumber = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fullAnimation(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tapGesture)
        heartAppeared.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
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
        let boundNumber = publicData.counter
        if countNumber < boundNumber {
            countNumber += 1
        } else {
            countNumber = 1
        }
//        totalNumber += 1
        countLabel.text = "\(countNumber)"
//        totalLabel.text = "\(totalNumber)"
    }
    
    @objc func fullAnimation(_ sender: UIImageView) {
        setupTasbihAnimation(butirChoosen: butir1)
        setupTasbihAnimation(butirChoosen: butir2)
        setupTasbihAnimation(butirChoosen: butir3)
        setupTasbihAnimation(butirChoosen: butir4)
        setupTasbihAnimation(butirChoosen: butir5)
        setupTasbihAnimation(butirChoosen: butir6)
        setupTasbihAnimation(butirChoosen: butir7)
        setupTasbihAnimation(butirChoosen: butir8)
        setupTasbihAnimation(butirChoosen: butir9)
        setupTasbihAnimation(butirChoosen: butir10)
        setupTasbihAnimation(butirChoosen: butir11)
        setupTasbihAnimation(butirChoosen: butir12)
        setupTasbihAnimation(butirChoosen: butir13)
        setupTasbihAnimation(butirChoosen: butir14)
        setupTasbihAnimation(butirChoosen: butir15)
        setupTasbihAnimation(butirChoosen: butir16)
        setupTasbihAnimation(butirChoosen: butir17)
        setupTasbihAnimation(butirChoosen: butir18)
        setupTasbihAnimation(butirChoosen: butir19)
    
        setupCount()
        heartAppeared.isHidden = true
        countLabel.isHidden = false
        countBip.isHidden = false
        slashOutlet.isHidden = false
        
        if soundLabel.currentImage == UIImage(named: "sounds on") {
            playSound(selectedSoundFileName: "tap D-Dzikr")
        }
        
        if countLabel.text == bipEvery {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            heartAppeared.isHidden = false
            countLabel.isHidden = true
            countBip.isHidden = true
            slashOutlet.isHidden = true
            fadeOut()
        }
        
    }
    
    
    func setupTasbihAnimation(butirChoosen : UIImageView) {
        let path = UIBezierPath()
        path.move(to: butirChoosen.center)
        //x += 21 dan y += 18 dari objek target pada main.storyboard
        if butirChoosen == butir1 {
            let targetPoint = CGPoint(x: 294, y: 329)
            let controlPoint = CGPoint(x: view.frame.width/2, y: 280)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        }else if butirChoosen == butir2 {
            let targetPoint = CGPoint(x: 121, y: 329)
            let controlPoint = CGPoint(x: butir2.frame.midX, y: butir2.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir3 {
            let targetPoint = CGPoint(x: 90, y: 355)
            let controlPoint = CGPoint(x: butir3.frame.midX, y: butir3.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir4 {
            let targetPoint = CGPoint(x: 71, y: 391)
            let controlPoint = CGPoint(x: butir4.frame.midX, y: butir4.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir5 {
            let targetPoint = CGPoint(x: 60, y: 431)
            let controlPoint = CGPoint(x: butir5.frame.midX, y: butir5.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir6 {
            let targetPoint = CGPoint(x: 61, y: 473)
            let controlPoint = CGPoint(x: butir6.frame.midX, y: butir6.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir7 {
            let targetPoint = CGPoint(x: 73, y: 513)
            let controlPoint = CGPoint(x: butir7.frame.midX, y: butir7.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir8 {
            let targetPoint = CGPoint(x: 95, y: 548)
            let controlPoint = CGPoint(x: butir8.frame.midX, y: butir8.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir9 {
            let targetPoint = CGPoint(x: 127, y: 575)
            let controlPoint = CGPoint(x: butir9.frame.midX, y: butir9.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir10 {
            let targetPoint = CGPoint(x: 166, y: 590)
            let controlPoint = CGPoint(x: butir10.frame.midX, y: butir10.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir11 {
            let targetPoint = CGPoint(x: 207, y: 596)
            let controlPoint = CGPoint(x: butir11.frame.midX, y: butir11.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir12 {
            let targetPoint = CGPoint(x: 248, y: 590)
            let controlPoint = CGPoint(x: butir12.frame.midX, y: butir12.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir13 {
            let targetPoint = CGPoint(x: 286, y: 575)
            let controlPoint = CGPoint(x: butir13.frame.midX, y: butir13.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir14 {
            let targetPoint = CGPoint(x: 318, y: 548)
            let controlPoint = CGPoint(x: butir14.frame.midX, y: butir14.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir15 {
            let targetPoint = CGPoint(x: 341, y: 513)
            let controlPoint = CGPoint(x: butir15.frame.midX, y: butir15.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir16 {
            let targetPoint = CGPoint(x: 354, y: 473)
            let controlPoint = CGPoint(x: butir16.frame.midX, y: butir16.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir17 {
            let targetPoint = CGPoint(x: 356, y: 431)
            let controlPoint = CGPoint(x: butir17.frame.midX, y: butir17.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir18 {
            let targetPoint = CGPoint(x: 345, y: 391)
            let controlPoint = CGPoint(x: butir18.frame.midX, y: butir18.frame.midY)
            path.addQuadCurve(to: targetPoint, controlPoint: controlPoint)
        } else if butirChoosen == butir19 {
            let targetPoint = CGPoint(x: 326, y: 355)
            let controlPoint = CGPoint(x: butir19.frame.midX, y: butir19.frame.midY)
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
            self.fadeOut()
        }
    
    

}

}
