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
//fungsi struct ialah cara cepat transfer data antar view, static artinya datanya tetep kesimpen gitu
struct publicData{
    static var counter : Int = 1
}
class ViewController: UIViewController, AVAudioPlayerDelegate, UITextFieldDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    var countNumber : Int = 0
//    var totalNumber : Int = 0
    var bipTextField = UITextField()
    var bipEvery : String = ""
    var p0 : CGPoint!
    var p1 : CGPoint!
    var p2 : CGPoint!
    var butir1Position: CGPoint!
    
    var bezierPath = UIBezierPath()
    var bezierPathXMax: CGFloat!
    
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
            backgroundMusic(volume: 0)
        } else {
            let image = UIImage(named: "sounds on")
            soundLabel.setImage(image, for: .normal)
            backgroundMusic(volume: 0.1)
        }
    }
    
    
    @IBAction func repeatAction(_ sender: Any) {
        countNumber = 0
//        totalNumber = 0
        countLabel.text = "\(countNumber)"
//        totalLabel.text = "\(totalNumber)"
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
    }
    
    @IBAction func bipEveryButton(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) -> Void in
            self.bipTextField = textField
            self.bipTextField.delegate = self //REQUIRED
            self.bipTextField.placeholder = "Beep every"
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
    
    func backgroundMusic(volume : Double) {
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "water sound", ofType: "wav")!)
        
        audioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        
        audioPlayer.prepareToPlay()
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        
        audioPlayer.volume = Float(volume)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundMusic(volume: 0.1)
        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fullAnimation(_:)))
        countBip.text = String(publicData.counter)
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tapGesture)
        heartAppeared.isHidden = true
        
//        drawBezierPath()
//        let dragPan = UIPanGestureRecognizer(target: self, action: #selector(dragButir1OnBezier(recognizer:)))
//        butir1.addGestureRecognizer(dragPan)
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert()
        //set the butir1 center at randon point on Bezier path. Setting the starting point here
//        butir1.center = p0
        //store the initial position of butir1
//        butir1Position = p0
    }
    /*
     Draw Bezier Quad curve and get the path.
     */
    func drawBezierPath() {
        //view x 207 view y 448
        p0 = CGPoint(x: view.center.x - 86, y: view.center.y - 119)

        p2  = CGPoint(x: view.center.x + 87, y: view.center.y - 119)

        p1 = CGPoint(x: view.frame.width/2, y: 276)
        print(p1.x)
        print(p1.y)

        bezierPath.move(to: p0)
        bezierPath.addQuadCurve(to: p2, controlPoint: p1)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
        butir1.translatesAutoresizingMaskIntoConstraints = true

        //Store the max Y distance covered by UIbezierPath. It will be useful to calculate the intermidiate point on curve
        // at the distance y from the start point po
        bezierPathXMax = p2.x - p0.x

    }

    
    /* Refered from http://ericasadun.com/2013/03/25/calculating-bezier-points/
     - params: start point, end point, control point and the time drawn factor between 0 to 1.
     */
    func getPointAtPercent(t: Float, start: Float, c1: Float, end: Float ) -> Float {
        let t_: Float = (1.0 - t)
        let tt_: Float = t_ * t_
        let tt: Float = t * t

        return start * tt_
            + 2.0 * c1 * t_ * t
            + end * tt
    }


    @objc func dragButir1OnBezier(recognizer: UIPanGestureRecognizer) {

        let point = recognizer.location(in: view)
        let distanceX = point.x - butir1Position.x
        // get the value between 0 & 1. 0 represents and po and 1 represent p2.
        var distanceXInRange = distanceX / bezierPathXMax
        distanceXInRange = distanceXInRange > 0 ? distanceXInRange : -distanceXInRange

        if distanceXInRange >= 1 || distanceXInRange <= 0 {
            // already at the end of the curve. So need to drag
            return
        }

        // get the x,y point on the Bezier path at a distance distanceYInRange from p.
        let newY = getPointAtPercent(t: Float(distanceXInRange), start: Float(p0.y) , c1: Float(p1.y), end: Float(p2.y))

        let newX = getPointAtPercent(t: Float(distanceXInRange), start: Float(p0.x) , c1: Float(p1.x), end: Float(p2.x))

        // set the newLocation of the butir1
        butir1.center = CGPoint(x: CGFloat(newX), y: CGFloat(newY))
//        if p2.x-10...p2.x+10 ~= CGFloat(newX) && p2.y-10...p2.y+10 ~= CGFloat(newY) {
//            self.butir1.frame.origin.x = 121
//            self.butir1.frame.origin.y = 329
//            butirLainAction()
//        }
        
        
        
//        if CGFloat(newX) == p2.x && CGFloat(newY) == p2.y {
//        butirLainAction()
//        }

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
        butirLainAction()
    }
    
    func butirLainAction() {
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
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        setupCount()
        heartAppeared.isHidden = true
        countLabel.isHidden = false
        countBip.isHidden = false
        slashOutlet.isHidden = false
        
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
            let controlPoint = CGPoint(x: view.frame.width/2, y: 276)
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
